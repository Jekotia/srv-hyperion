$radarr_reverse_proxy = @("EOT"/$)
location /radarr {
  proxy_pass  http://127.0.0.1:${_RADARR_PORT};
  proxy_set_header X-Real-IP \$remote_addr;
  proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  proxy_redirect off;
  proxy_set_header Host \$host;
}
EOT

#file { "/etc/nginx/sites-enabled/radarr.${_DNS_NAME}":
file { "/etc/nginx/${_NAME}-locations/radarr":
  ensure  => file,
  content => $radarr_reverse_proxy,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
