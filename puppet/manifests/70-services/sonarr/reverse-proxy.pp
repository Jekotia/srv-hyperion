$sonarr_reverse_proxy = @("EOT"/$)
location /sonarr {
  proxy_pass          http://127.0.0.1:${_SONARR_PORT};

  proxy_set_header    X-Real-IP            \$remote_addr;
  proxy_set_header    Host                 \$host;
  proxy_set_header    X-Forwarded-For      \$proxy_add_x_forwarded_for;
  proxy_set_header    X-Forwarded-Proto    \$scheme;

  proxy_redirect off;
  proxy_buffering off;

  # proxy_http_version      1.1;
  # proxy_set_header        X-Forwarded-Host \$http_host;
  # http2_push_preload on; # Enable http2 push
}
EOT

#file { "${_NGINX_LOCATIONS}/sonarr.conf":
#file { "/etc/nginx/sites-enabled/sonarr.${_DNS_NAME}":
file { "/etc/nginx/${_NAME}-locations/sonarr":
  ensure  => file,
  content => $sonarr_reverse_proxy,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
