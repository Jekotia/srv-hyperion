file { $_QBITTORRENT_DATA:
  ensure => directory,
  owner  => $_QBITTORRENT_USER,
  group  => $_QBITTORRENT_GROUP,
}

chown_r { $_QBITTORRENT_DATA:
  want_user   => $_QBITTORRENT_USER,
  want_group  => $_QBITTORRENT_GROUP,
}

chmod_r { $_QBITTORRENT_DATA:
  want_mode => "0755",
}
