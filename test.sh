#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR" || exit 1

./scripts/merge-compose-parts.sh && ./scripts/copy-env.sh && docker-compose up -d --remove-orphans $*
