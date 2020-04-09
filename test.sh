#! /bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
cd "$DIR" || exit 1

# DOCKER
function dstopcont() { sudo docker stop $(docker ps -a -q) $*; }
function dstopall() { sudo docker stop $(sudo docker ps -aq) $*; }
function drmcont() { sudo docker rm $(docker ps -a -q) $*; }
function dvolprune() { sudo docker volume prune $*; }
function dsysprune() { sudo docker system prune -a $*; }
function ddelimages() { sudo docker rmi $(docker images -q) $*; }
function docerase() { dstopcont $* ; drmcont $* ; ddelimages $* ; dvolprune $*; dsysprune $*; }
function docprune() { ddelimages $*; dvolprune $*; dsysprune $*; }
function dexec() { docker exec -ti $*; }
function docps() { docker ps -a $*; }
function dcrm() { dcrun rm $*; }
function docdf() { docker system df $*; }

# STACK UP AND DOWN
function dc2down() { cd "${DIR}" ; dcdown2v $*; dcdown2 $*; }
function dc2up() { cd "${DIR}" ; docker network create --gateway 192.168.90.1 --subnet 192.168.90.0/24 t2_proxy $*; dcrec2 plexms $*; dcup2 $*; dcup2v $*; }

# DOCKER TRAEFIK 2
function dcrun2() { cd "${DIR}" ; docker-compose -f "${DIR}/docker-compose.yml" $*; }
function dclogs2() { cd "${DIR}" ; docker-compose -f "${DIR}/docker-compose.yml" logs -tf --tail="50" $*; }
function dcup2() { dcrun2 up -d $*; }
function dcdown2() { dcrun2 down $*; }
function dcrec2() { dcrun2 up -d --force-recreate $*; }
function dcstop2() { dcrun2 stop $*; }
function dcrestart2() { dcrun2 restart $*; }
function dcpull2() { cd "${DIR}" ; docker-compose -f "${DIR}"/docker-compose.yml  pull $*; }

# DOCKER TRAEFIK 2 VPN
function dcrun2v() { cd "${DIR}" ; docker-compose -f "${DIR}/docker-compose-t2-vpn.yml" $*; }
function dclogs2v() { cd "${DIR}" ; docker-compose -f "${DIR}/docker-compose-t2-vpn.yml" logs -tf --tail="50" $*; }
function dcup2v() { dcrun2v up -d $*; }
function dcdown2v() { dcrun2v down; }
function dcrec2v() { dcrun2v up -d --force-recreate $*; }
function dcstop2v() { dcrun2v stop $*; }
function dcrestart2v() { dcrun2v restart $*; }
function dcpull2v() { cd "${DIR}" ; docker-compose -f "${DIR}/docker-compose-t2-vpn.yml"  pull $*; }

./scripts/merge-compose-parts.sh && docker-compose up -d