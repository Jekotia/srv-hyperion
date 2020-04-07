# Summary

Currently migrating to Docker.

For easier maintainability, each service has its own fully qualified Compose file under the `./docker-compose-parts` directory. Execute `./scripts/merge-compose-parts.sh` to produce `./docker-compose.yml`.
