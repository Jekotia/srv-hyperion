file { $_SONARR_DATA:
  ensure => directory,
  owner  => $_SONARR_USER,
  group  => $_SONARR_GROUP,
}

chown_r { $_SONARR_DATA:
  want_user   => $_SONARR_USER,
  want_group  => $_SONARR_GROUP,
}

# chmod_r { $_SONARR_DATA:
#   want_mode => "0755",
# }

# chmod_r { "${_SONARR_DATA}/config/*":
#   want_mode => "0644",
# }

# chmod_r { "${_SONARR_DATA}/config/app":
#   want_mode => "0755",
# }

# chmod_r { "${_SONARR_DATA}/config/logs":
#   want_mode => "0755",
# }

# chmod_r { "${_SONARR_DATA}/config/logs/sonarr.txt":
#   want_mode => "0644",
# }

file { "${_TORRENTS}/tv-sonarr":
  ensure => directory,
  owner  => $_QBITTORRENT_USER,
  group  => $_MULTIMEDIA_GROUP,
}
chown_r { "${_TORRENTS}/tv-sonarr":
  want_user   => $_QBITTORRENT_USER,
  want_group  => $_MULTIMEDIA_GROUP,
}
chmod_r { "${_TORRENTS}/tv-sonarr":
  want_mode => "0775",
}
