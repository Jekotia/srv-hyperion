#-> https://github.com/Radarr/Radarr/wiki/Autostart-on-Linux

$radarr_unit_file = @("EOT")
[Unit]
Description=Radarr Daemon
After=syslog.target network.target

[Service]
# Change the user and group variables here.
User=${_RADARR_USER}
Group=${_RADARR_GROUP}

Type=simple

# Change the path to Radarr or mono here if it is in a different location for you.
ExecStart=/usr/bin/mono --debug ${_RADARR_DIR}/Radarr.exe -nobrowser -data=${_RADARR_DATA}/config
TimeoutStopSec=20
KillMode=process
Restart=on-failure

# These lines optionally isolate (sandbox) Radarr from the rest of the system.
# Make sure to add any paths it might use to the list below (space-separated).
#ReadWritePaths=/opt/Radarr /path/to/movies/folder
#ProtectSystem=strict
#PrivateDevices=true
#ProtectHome=true

[Install]
WantedBy=multi-user.target
EOT

file { "/tmp/radarr.service":
  ensure  => file,
  content => $radarr_unit_file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}

systemd::unit_file { 'radarr.service':
  source => "/tmp/radarr.service",
  enable => true,
  active => true,
}
