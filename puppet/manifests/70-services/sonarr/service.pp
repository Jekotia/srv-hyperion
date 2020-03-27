#-> https://github.com/Sonarr/Sonarr/wiki/Autostart-on-Linux

$sonarr_unit_file = @("EOT")
[Unit]
Description=Sonarr Daemon
After=network.target

[Service]
# Change and/or create the required user and group.
User=sonarr
Group=sonarr

# The UMask parameter controls the permissions of folders and files created.
#UMask=002

# The -data=/path argument can be used to force the config/db folder
ExecStart=/usr/bin/mono --debug /opt/NzbDrone/NzbDrone.exe -nobrowser -data=${_SONARR_DATA}/config

Type=simple
TimeoutStopSec=20
KillMode=process
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOT

file { "/tmp/sonarr.service":
  ensure  => file,
  content => $sonarr_unit_file,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}

systemd::unit_file { 'sonarr.service':
  source => "/tmp/sonarr.service",
  enable => true,
  active => true,
}
