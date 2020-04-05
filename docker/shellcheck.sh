#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${DIR}" || exit 1

shellcheck "$(realpath -s "$0")" \
&& shellcheck -x backup-data.sh \
&& shellcheck merge.sh \
&& shellcheck test.sh
