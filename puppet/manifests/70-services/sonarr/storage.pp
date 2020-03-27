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
