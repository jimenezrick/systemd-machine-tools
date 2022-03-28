#!/bin/bash

set -eu

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BASE_PKGS=(base base-devel devtools bash-completion vi)
BASE_ROOTFS=pacstrap
TARGET_PKGS=()
TARGET_AUR_PKGS=()
SETUP_SCRIPTS=()
CONTAINER=

usage() {
	cat <<EOF
Usage: $0 [-c <container_name>] [-r] [-p <pacman_pkg>] [-a <aur_pkg>] [-s <setup_script>] ...

    -c Name of the container rootfs directory
    -r Download the official bootstrap rootfs as base
    -p Install target package from official repositories
    -a Install target package from AUR
    -s Run setup script inside the container
EOF
	exit 0
}

die() {
	echo "$@" >&2
	exit 1
}

run() {
	local container=$1
	shift

	run_as $container root "$@"
}

run_as() {
	local container=$1
	local user=$2
	shift 2

	run_as_from $container $user / "$@"
}

run_as_from() {
	local container=$1
	local user=$2
	local dir=$3
	shift 3

	systemd-nspawn -D $container --user $user --chdir $dir "$@"
}

parse_opts() {
	while getopts 'hrc:s:p:a:' OPTFLAG
	do
		case ${OPTFLAG} in
			h)
				usage
				;;
			c)
				CONTAINER=($OPTARG)
				;;
			r)
				BASE_ROOTFS=archive
				;;
			p)
				TARGET_PKGS+=($OPTARG)
				;;
			a)
				TARGET_AUR_PKGS+=($OPTARG)
				;;
			s)
				SETUP_SCRIPTS+=($OPTARG)
				;;
			?)
				die "error: invalid option"
				;;
		esac
	done
}

fetch_bootstrap_rootfs() {
	local version=$(date +%Y.%m.01)
	local mirror=https://lon.mirror.rackspace.com
	local image=archlinux-bootstrap-$version-x86_64.tar.gz
	local url=$mirror/archlinux/iso/$version/$image

	if [[ ! -f $image ]]
	then
		wget $url
	fi

	tar xf $image
	mv -v root.x86_64 $CONTAINER
}

run_setup_script() {
	cp -v $1 $CONTAINER/build-scripts/setup/
	run $CONTAINER /build-scripts/setup/$1
}

parse_opts "$@"

if [[ $(whoami) != "root" ]]
then
	die "error: needs to be run as root"
fi

if [[ -z $CONTAINER ]]
then
	die "error: container name not specified"
fi

# Bootstrap rootfs
case $BASE_ROOTFS in
	archive)
		fetch_bootstrap_rootfs
		cp -rv $SCRIPT_DIR/build-scripts/ $CONTAINER/
		run $CONTAINER /build-scripts/prepare-rootfs.sh
		run $CONTAINER pacman -S --noconfirm ${BASE_PKGS[@]}
		;;
	pacstrap)
		mkdir -p $CONTAINER
		pacstrap -c $CONTAINER ${BASE_PKGS[@]}
		cp -rv $SCRIPT_DIR/build-scripts/ $CONTAINER/
		;;
esac

mkdir -p $CONTAINER/build-scripts/setup

# Prepare container
run $CONTAINER /build-scripts/add-users.sh
run_as_from $CONTAINER builder /home/builder /build-scripts/install-aurutils.sh

# Install packages
run_as $CONTAINER builder /build-scripts/build-aur-pkgs.sh "${TARGET_AUR_PKGS[@]}"
run $CONTAINER pacman -S --noconfirm "${TARGET_PKGS[@]}" "${TARGET_AUR_PKGS[@]}"

# Setup container
for script in "${SETUP_SCRIPTS[@]}"
do
	run_setup_script $script
done

# Cleanup
run $CONTAINER /build-scripts/cleanup.sh
