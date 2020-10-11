#!/bin/bash
#
# See https://stackoverflow.com/a/14099762
#
# This script is free as in free beer, free speech and free baby.
# This script is a far too complex solution to such a simple problem (which isn't my fault)!

VER=86.0.4240.75
EXAMPLE="https://chrome.google.com/webstore/detail/*/*"

: getver
getver()
{
	ver="$1"
	if	[ -z "$ver" ]
	then
		ver="$(dpkg-query --showformat='${Version}' --show google-chrome-stable)"
		ver="${ver%-*}"
	fi
	ver="${ver:-$VER}"
	[ 0 = $# ] && read -rp 'Google-Chrome Version: ' -ei "$ver" ver
}

: show VER URL
show()
{
	getver "$1"

	ext="${2##*/}"
	name="${2%/*}"
	name="${name##*/}"

	printf -v esc ' %q' -O "$name.$ext.crx" "https://clients2.google.com/service/update2/crx?response=redirect&&acceptformat=crx2,crx3&x=id%3D$ext%26uc&prodversion=$ver"
	printf 'wget%s\n' "$esc"
	exit 0
}

: url VER URL
url()
{
	case "$2" in
	(https://chrome.google.com/webstore/detail/*/*/*/*)	;;
	(https://chrome.google.com/webstore/detail/*/*/related)	show "$1" "${2%/related}";;
	(https://chrome.google.com/webstore/detail/*/*/*)	;;
	(https://chrome.google.com/webstore/detail/*/*)		show "$1" "$2";;
	esac

	printf 'Sorry, URL %q not understood\nvalid URLs look like this\n%q\n' "$2" "$EXAMPLE" >&2
	exit 23
}

: ask [VER]
ask()
{
	getver "$@"

	while	read -rp 'Google Webstore Extension URL: ' url
	do
		printf '\n'
		( url "$ver" "$url" )
		printf '\n'
	done
	exit 1	# interactive isn't scriptable
}

: usage
usage()
{
	printf 'Usage: %q [chrome-version [webstore-URL]]\n' "${0##*/}" >&2
	exit 42
}

case "$1" in
(''|[0-9]*.*[0-9])	;;
(*)			usage;;
esac

case "$#" in
(0|1)	ask "$@";;
(2)	url "$@";;
esac

usage

