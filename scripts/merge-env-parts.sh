#! /bin/bash

declare -a static_parts=(
	"common.env"
	"secrets.env"
)

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
base_path="$(dirname "$DIR")"

cd "$base_path" || exit 1

compose_parts_dir="${base_path}/compose-parts"
env_parts_dir="${base_path}/env-parts"
output_file="${base_path}/.env"

function fileStart() { echo "Merging '${file}' into '${output_file}'"; echo "# BEGIN -> ./${file}" >> "${output_file}"; }
function fileEnd() { echo "# END -> ${file}" >> "${output_file}"; echo "" >> "${output_file}"; }
function fileFail() { echo "Failed to append '${file}' to ${output_file}"; exit 1; }
function localPath() { echo "$*" | sed 's,'"$base_path"'/\(.*\),\1,g'; }

output_file=$(localPath "$output_file")

while [ -e $output_file ] ; do
	rm -f "${output_file}"
done

if ! touch "${output_file}" ; then
	echo "Failed to touch '${output_file}'"
	exit 1
fi

for file in "${static_parts[@]}" ; do
	file=$(localPath "$file")
	fileStart
	if ! cat "${env_parts_dir}/${file}" >> "${base_path}/${output_file}" ; then
		fileFail
		exit 1
	fi
	fileEnd
done

for file in "${compose_parts_dir}"/*/*.production.yml ; do
	file=$(localPath "${file}")
	file="$(
		echo "$file" \
		| sed 's/compose\-parts/env\-parts/g' \
		| sed 's/\.production\.yml/\.env/g'
	)"

	if [ -e ${base_path}/${file} ] ; then
		fileStart
		if ! cat "${base_path}/${file}" >> "${base_path}/${output_file}" ; then
			fileFail
		fi
		fileEnd
	else
		echo "Found no matching .env file for '$file'"
	fi
done
