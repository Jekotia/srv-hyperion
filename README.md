# Summary

Currently migrating to Docker.

For easier maintainability, each service has its own fully qualified Compose file under the `docker/` directory. Execute `docker/merge.sh` to produce `docker-compose.yml`.

`docker/test.sh` is designed to make iteration easier during development and will be removed when Hyperion is finalised.
