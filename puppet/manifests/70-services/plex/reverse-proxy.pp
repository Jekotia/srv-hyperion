$plex_reverse_proxy = @("EOT"/$)
# location /plex {
#   proxy_pass              http://127.0.0.1:${_PLEX_PORT};
#   proxy_http_version      1.1;
#   proxy_set_header        X-Forwarded-Host \$http_host;
#   http2_push_preload on; # Enable http2 push
# }
location /web {
  # proxy_pass http://192.168.x.x:32400;     //Plex Media Server address
  proxy_pass              http://127.0.0.1:${_PLEX_PORT};
  proxy_set_header Host \$host;
  proxy_set_header X-Real-IP \$remote_addr;
  proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
}

location /plex {
  proxy_pass http://127.0.0.1/web;
}

EOT

#file { "/etc/nginx/sites-enabled/plex.${_DNS_NAME}":
file { "/etc/nginx/${_NAME}-locations/plex":
  ensure  => file,
  content => $plex_reverse_proxy,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
