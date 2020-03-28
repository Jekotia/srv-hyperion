#! /bin/bash
_RADARR_DIR="/opt/Radarr/"

fileurl="$( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )"
filename="${fileurl##*/}"

mkdir /tmp/radarr-install \
&& cd /tmp/radarr-install \
&& curl -L -O "$fileurl" \
&& tar -xzf "$filename" \
&& mv Radarr "$(dirname ${_RADARR_DIR})" \
&& chmod -R +r "${_RADARR_DIR}" \
&& chmod +x "${_RADARR_DIR/Radarr.exe}"

status=$?

counter=1
while [ -e /tmp/radarr-install ] ; do
    if [ $counter -gt 5 ] ; then
        break
    elif [ $counter -ne 1 ] ; then
        sleep 3
    fi
    rm -rf /tmp/radarr-install
    ((counter++))
done

exit $status