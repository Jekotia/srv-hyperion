$radarr_reverse_proxy = @("EOT"/$)
server
{
  listen      80;
  server_name    radarr.${_DNS_NAME};

  location /
  {
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_redirect off;
    proxy_set_header Host \$host;
    proxy_pass  http://localhost:7878;
  }

  access_log            ${_LOGS}/nginx/radarr.${_DNS_NAME}.access.log combined;
  error_log             ${_LOGS}/nginx/radarr.${_DNS_NAME}.error.log;
}
EOT

file { "/etc/nginx/sites-enabled/radarr.${_DNS_NAME}":
  ensure  => file,
  content => $radarr_reverse_proxy,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
