#-> https://github.com/qbittorrent/qBittorrent/wiki/Setting-up-qBittorrent-on-Ubuntu-server-as-daemon-with-Web-interface-(15.04-and-newer)

apt::ppa { 'ppa:qbittorrent-team/qbittorrent-stable': }

$qbittorrent_packages = [
  'qbittorrent-nox',
]

package { $qbittorrent_packages: ensure => 'installed' }
