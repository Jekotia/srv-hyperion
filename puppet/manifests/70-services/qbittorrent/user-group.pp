#-> https://github.com/qbittorrent/qBittorrent/wiki/Setting-up-qBittorrent-on-Ubuntu-server-as-daemon-with-Web-interface-(15.04-and-newer)

user { $_QBITTORRENT_USER:
  ensure => present,
  groups => [ $_QBITTORRENT_GROUP, $_MULTIMEDIA_GROUP ],
  home   => $_QBITTORRENT_DATA,
  shell  => '/usr/sbin/nologin',
}

group { $_QBITTORRENT_GROUP:
  ensure => present,
}
