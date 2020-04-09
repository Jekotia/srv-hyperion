#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "${DIR}" || exit 1

sed \
    -e 's/^_HYPERION_SECRETS_\(.*\)=.*$/_HYPERION_SECRETS_\1=/g' \
    "${DIR}/../.env" > "${DIR}/../.env.example"
