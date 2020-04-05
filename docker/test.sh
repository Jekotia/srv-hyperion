#! /bin/bash
#mkdir -p ../data/jackett/config ../data/web ../data/caddy ../data/plex/config ../data/sonarr/config  ../data/radarr/config ../data/qbittorrent/config ../multimedia/downloads/complete ../multimedia/downloads/incomplete ../multimedia/tv ../multimedia/movies
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR" || exit 1

"$DIR/merge.sh"

declare -a dockerimages=(
	"linuxserver/jackett"
	"linuxserver/lazylibrarian"
	"linuxserver/lidarr"
	"linuxserver/ombi"
	"organizrtools/organizr-v2:plex"
	"plexinc/pms-docker"
	"linuxserver/qbittorrent"
	"linuxserver/radarr"
	"linuxserver/sonarr"
	"nginx:alpine"
)

function _up()      { docker-compose up -d --remove-orphans; }
function _down()    { docker-compose down -v --remove-orphans; }
function _restart() { docker-compose restart --remove-orphans; }
function _ps()      { command docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}" | more; }

case $1 in
	up)
		_up
		_ps
	;;
	down)
		_down
		_ps
	;;
	restart)
		_restart
		_ps
	;;
	reset)
		_up
		_down
		_ps
	;;
	pull)
		for image in "${dockerimages[@]}" ; do 
			docker pull "$image"
		done
	;;
	*)
		echo "Usage: "
		echo "  up"
		echo "  down"
		echo "  restart"
		echo "  reset"
		echo "  pull"
	;;
esac
