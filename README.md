
# Hyperion

## WARNING

Nothing about this repo should yet be considered to be stable. Attempting to customise this project for your own use, while maintaining easy updating (e.g. custom env file and `git pull`'ing in new changes) is a bad idea.

## Summary

Currently migrating to Docker.

For easier maintainability, each service has its own fully qualified Compose file under the `./compose-parts` directory. Execute `./scripts/merge-compose-parts.sh` to produce `./docker-compose.yml`. Each service also has its own .env file under the `./env-parts` directory. Execute `./scripts/merge-env-parts.sh` to produce `./.env`.

## Compose File Naming

In order to be properly handled and merged by `./scripts/merge-compose-parts.sh` compose files must be named using the convention of `./compose-parts/<directory>/<servicename>.production.yml`. If a file is production-ready but not being used, the file name should be `<servicename>.prod.yml`. This signifies to users browsing the repository that the file is production-ready, without it being included by the merge script.

## Scripts

### ./test.sh

This script executes the scripts required to merge compose & env files, copy secret-cleansed versions of `./.env` and `./env-parts/secrets.env` to `./.env.example` and `./env-parts/secrets.env.example` respectively, and then bring up the 'stack' based on the merged files. It is intended for development purposes.

### ./scripts/merge-env-parts.sh

This script searches for `./compose-parts/*/*.production.yml` files and merges the matching `./env-parts/*/*.env` files, if they exist, into `./.env`
