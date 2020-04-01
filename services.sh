#! /bin/bash

declare -a services=(
    "plexmediaserver" "sonarr" "radarr" "qbittorrent" "nginx"
)
declare -a docker_services=(
    "jackett"
)
case $1 in
    status|start|stop|restart)
        for service in "${services[@]}" ; do
            if [[ "$1" == "status" ]] ; then
                systemctl status $service --no-pager > /dev/null
                status=$?
                
                echo "$service"

                if [[ $status -eq 0 ]] ; then
                    echo " "$'\U21B3' "program is running or service is OK"

                elif [[ $status -eq 1 ]] ; then
                    echo " "$'\U21B3' "program is dead and /var/run pid file exists"

                elif [[ $status -eq 2 ]] ; then
                    echo " "$'\U21B3' "program is dead and /var/lock lock file exists"

                elif [[ $status -eq 3 ]] ; then
                    echo " "$'\U21B3' "program is not running"

                elif [[ $status -eq 4 ]] ; then
                    echo " "$'\U21B3' "program or service status is unknown"

                else
                    echo "The status code returned by systemctl is unknown to this script."
                fi
            else
                if systemctl $1 $service ; then
                    echo "Success: $1 $service"
                else
                    echo "Failure: $1 $service"
                fi
            fi
        done

        for service in "${docker_services[@]}" ; do
            if [[ "$1" == "status" ]] ; then
                docker ps | grep "$service" > /dev/null
                status=$?
                
                echo "$service"

                if [[ $status -eq 0 ]] ; then
                    echo " "$'\U21B3' "container is running"

                elif [[ $status -eq 1 ]] ; then
                    echo " "$'\U21B3' "container is not running"

                else
                    echo "The status code returned by docker is unknown to this script."
                fi
            else
                if docker $1 $service > /dev/null ; then
                    echo "Success: $1 $service"
                else
                    echo "Failure: $1 $service"
                fi
            fi
        done
    ;;
    *)
        echo "Supported systemctl commands are "
        echo "  status"
        echo "  start"
        echo "  stop"
        echo "  restart"
    ;;
esac
