file { "${_MULTIMEDIA}/Trash/Movies":
  ensure => directory,
  owner  => $_RADARR_USER,
  group  => $_RADARR_GROUP,
}
file { $_RADARR_DATA:
  ensure => directory,
  owner  => $_RADARR_USER,
  group  => $_RADARR_GROUP,
}
chown_r { $_RADARR_DATA:
  want_user   => $_RADARR_USER,
  want_group  => $_RADARR_GROUP,
}

file { "${_TORRENTS}/movies-radarr":
  ensure => directory,
  owner  => $_QBITTORRENT_USER,
  group  => $_MULTIMEDIA_GROUP,
}
chown_r { "${_TORRENTS}/movies-radarr":
  want_user   => $_QBITTORRENT_USER,
  want_group  => $_MULTIMEDIA_GROUP,
}
chmod_r { "${_TORRENTS}/movies-radarr":
  want_mode => "0775",
}
