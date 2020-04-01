$jackett_reverse_proxy = @("EOT"/$)
location /jackett {
  proxy_pass http://127.0.0.1:${_JACKETT_PORT};
  proxy_set_header X-Real-IP \$remote_addr;
  proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
  proxy_set_header X-Forwarded-Proto \$scheme;
  proxy_set_header X-Forwarded-Host \$http_host;
  proxy_redirect off;
}
EOT

#file { "/etc/nginx/sites-enabled/jackett.${_DNS_NAME}":
file { "/etc/nginx/${_NAME}-locations/jackett":
  ensure  => file,
  content => $jackett_reverse_proxy,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
