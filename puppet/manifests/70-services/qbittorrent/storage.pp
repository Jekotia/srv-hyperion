#-> Application configuration
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


#-> Torrents Directories
file { $_TORRENTS:
  ensure => directory,
  owner  => $_QBITTORRENT_USER,
  group  => $_MULTIMEDIA_GROUP,
  mode   => "0755",
}

file { "${_TORRENTS}/Incomplete":
  ensure => directory,
  owner  => $_QBITTORRENT_USER,
  group  => $_MULTIMEDIA_GROUP,
}
chown_r { "${_TORRENTS}/Incomplete":
  want_user   => $_QBITTORRENT_USER,
  want_group  => $_MULTIMEDIA_GROUP,
}
chmod_r { "${_TORRENTS}/Incomplete":
  want_mode => "0740",
}

file { "${_TORRENTS}/Complete":
  ensure => directory,
  owner  => $_QBITTORRENT_USER,
  group  => $_MULTIMEDIA_GROUP,
}
chown_r { "${_TORRENTS}/Complete":
  want_user   => $_QBITTORRENT_USER,
  want_group  => $_MULTIMEDIA_GROUP,
}
chmod_r { "${_TORRENTS}/Complete":
  want_mode => "0775",
}
