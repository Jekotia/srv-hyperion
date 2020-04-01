#! /bin/bash
outFile="${_ROOT}/www/index.html"

declare -a names;          declare -a links;                               declare -a icons;                declare -a descriptions;
names+=( "Plex" );         links+=( "http://${_PLEX_LOCAL_URL}" );         icons+=( "bx-play-circle" );     descriptions+=( "Self-hosted, remotely-accessible, media server" );
names+=( "Sonarr" );       links+=( "http://${_SONARR_LOCAL_URL}" );       icons+=( "bx-tv" );              descriptions+=( "Smart PVR for newsgroup and bittorrent users" );
names+=( "Radarr" );       links+=( "http://${_RADARR_LOCAL_URL}" );       icons+=( "bx-movie" );           descriptions+=( "A fork of Sonarr to work with movies" );
names+=( "qBitTorrent" );  links+=( "http://${_QBITTORRENT_LOCAL_URL}" );  icons+=( "bx-cloud-download" );  descriptions+=( "The qBitTorrent client with an added Web GUI" );
names+=( "Jackett" );      links+=( "http://${_JACKETT_LOCAL_URL}" );      icons+=( "bx-rss" );             descriptions+=( "API Support for your favorite torrent trackers" );

if [ ! -e $outFile ] ; then
    echo "outFile does not exist: $outFile"
    exit 1
fi

length="${#names[@]}"
index=0

while [ $index -lt $length ] ; do
    name=${names[$index]}
    link=${links[$index]}
    icon=${icons[$index]}
    description=${descriptions[$index]}

    echo "${index}:name ${name}"
    echo "${index}:link ${link}"
    echo "${index}:icon ${icon}"
    echo "${index}:desc ${description}"

    #-> ICON
    find_icon="<div\sid='hyperion${index}'\sclass='icon'><i\sclass='.*'></i></div>"
    replace_icon="<div id='hyperion${index}' class='icon'><i class='bx ${icon}'></i></div>"
    sed -i "s|$find_icon|$replace_icon|g" $outFile

    #-> HREF
    find_href="<h4\sid='hyperion${index}'><a href='.*'>.*</a></h4>"
    replace_href="<h4 id='hyperion${index}'><a href='${link}'>${name}</a></h4>"
    sed -i "s|$find_href|$replace_href|g" $outFile

    #-> P
    find_p="<p\sid='hyperion${index}'>.*</p>"
    replace_p="<p id='hyperion${index}'>${description}</p>"
    sed -i "s|$find_p|$replace_p|g" $outFile


    ((index++))
    echo
done