# WARNING

Nothing about this repo should yet be considered to be stable. Attempting to customise this project for your own use, while maintaining easy updating (e.g. custom env file and `git pull`'ing in new changes) is a bad idea.

# Summary

Currently migrating to Docker.

For easier maintainability, each service has its own fully qualified Compose file under the `./compose-parts` directory. Execute `./scripts/merge-compose-parts.sh` to produce `./docker-compose.yml`.
