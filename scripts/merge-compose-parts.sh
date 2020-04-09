#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR" || exit 1

partsDir="${DIR}/../compose-parts"
output_file="$DIR/../docker-compose.yml"

if ! touch "${output_file}" ; then
	echo "Failed to touch '${output_file}'"
	exit 1
fi

if ! cat "${partsDir}/header.production.yml" > ${output_file} ; then
	echo "Failed to append './header.production.yml' to '${output_file}'"
	exit 1
fi

for file in "${partsDir}"/*/*.production.yml ; do
	echo "Merging '${file}' into '${output_file}'"

	if ! grep -vE -- "^version:.*$|^services:.*$" "${file}" >> "${output_file}" ; then
		echo "Failed to append '${file}' to ${output_file}"
		exit 1
	fi
done

if ! cat "${partsDir}/footer.production.yml" >> ${output_file} ; then
	echo "Failed to append './footer.production.yml' to '${output_file}'"
	exit 1
fi