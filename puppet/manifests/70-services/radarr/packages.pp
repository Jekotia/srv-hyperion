$radarr_packages = [
  'mediainfo',
]

package { $radarr_packages: ensure => 'installed' }

exec { "Install radarr":
  command   => "/usr/bin/bash ${_PUPPET_ROOT}/scripts/radarr-install.sh",
  creates   => "${_RADARR_DIR}/Radarr.exe",
  logoutput => true,
}
