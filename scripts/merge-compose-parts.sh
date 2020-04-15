#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
base_path="$(dirname "$DIR")"

cd "$base_path" || exit 1

partsDir="${base_path}/compose-parts"
output_file="${base_path}/docker-compose.yml"

function fileStart() {
	echo "Merging '${file}' into '${output_file}'"
	#echo "# BEGIN -> ${file}" >> "${output_file}"
}
#function fileEnd() { echo "# END -> ${file}" >> "${output_file}"; echo "" >> "${output_file}"; }
function fileFail() { echo "Failed to append '${file}' to ${output_file}"; exit 1; }
function localPath() { echo "$*" | sed 's,'"$base_path"'/\(.*\),\1,g'; } #function localPath() { echo "$*" | sed 's/.*\.\.\/\(.*\)/\.\/\1/g'; }


output_file=$(localPath "$output_file")

if ! touch "${output_file}" ; then
	echo "Failed to touch '${output_file}'"
	exit 1
fi

if ! printf "version: '3.7'\nservices:\n" > "${base_path}/${output_file}" ; then
	echo "Failed to append 'version: '3.7'\nservices:\n' to '${output_file}'"
	exit 1
fi

for file in "${partsDir}"/*/*.production.yml ; do
	file=$(localPath "$file")
	fileStart

	if ! grep -vE -- "^version:.*$|^services:.*$" "${base_path}/${file}" >> "${base_path}/${output_file}" ; then
		fileFail
	fi
done

for file in "${partsDir}"/*.production.yml ; do
	file=$(localPath "$file")
	fileStart

	if ! grep -vE -- "^version:.*$" "${base_path}/${file}" >> "${base_path}/${output_file}" ; then
		fileFail
	fi
done
