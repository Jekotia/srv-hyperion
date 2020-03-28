#! /bin/bash

./toggle.sh ./

./toggle.sh ./disabled-manifests

./toggle.sh ./manifests

./toggle.sh manifests/70-services/qbittorrent
./toggle.sh ./manifests/70-services/qbittorrent

./toggle.sh disabled-manifests/70-services/sonarr/
./toggle.sh ./disabled-manifests/70-services/sonarr/
