#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
path="$*"

if [[ ! $path =~ ^./ ]] ; then
	path="./$path"
fi

dirname="$(dirname $path)"

if [ ! -e $path ] ; then
	echo "Path does not exist: $path"
	exit 1
elif   [[ "$path" == "." ]] \
	|| [[ "$path" == "./" ]] \
	|| [[ "$path" == "./manifests" ]] \
	|| [[ "$path" == "./manifests/" ]] \
	|| [[ "$path" == "./disabled-manifests" ]] \
	|| [[ "$path" == "./disabled-manifests/" ]] ; then
	echo "Invalid: $path"
	exit 1
fi

if [[ $dirname =~ disabled-manifests ]] ; then
	echo "Enabling: $path"
	target="${path/\/disabled-manifests\//\/manifests\/}"
else
	echo "Disabling: $path"
	target="${path/\/manifests\//\/disabled-manifests\/}"
fi

target_dirname="$(dirname $target)"
mkdir -p $target_dirname

mv $path $target
