#! /bin/bash
bin_install_path="/usr/local/bin"
bash_completion_install_path="/etc/bash_completion.d"
version="1.25.4"

#---------------
bin_install_path="${bin_install_path}/docker-compose"
bash_completion_install_path="${bash_completion_install_path}/docker-compose"

case $1 in
    install)
        #fileurl="$( curl -s https://api.github.com/repos/Radarr/Radarr/releases | grep linux.tar.gz | grep browser_download_url | head -1 | cut -d \" -f 4 )"
        fileurl="https://github.com/docker/compose/releases/download/${version}/docker-compose-$(uname -s)-$(uname -m)"
        bash_completion_fileurl="https://raw.githubusercontent.com/docker/compose/${version}/contrib/completion/bash/docker-compose"

        curl -L "$fileurl" -o "${bin_install_path}" \
        && chmod +x "${bin_install_path}" \
        && curl -L "${bash_completion_fileurl}" -o "${bash_completion_install_path}"
        exit $?
    ;;
    remove)
        if dpkg -l | grep docker-compose ; then
            echo "docker-compose appears to be installed by apt"
            exit 1
        else
            rm "${bin_install_path}" "${bash_completion_install_path}"
            exit $?
        fi
    ;;
esac