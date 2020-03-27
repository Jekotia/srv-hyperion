$jackett_reverse_proxy = @("EOT"/$)
server {
  listen 80;
  listen [::]:80;

  server_name    jackett.${_DNS_NAME};

  location / {
    proxy_pass http://127.0.0.1:9117;
    proxy_set_header X-Real-IP \$remote_addr;
    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    proxy_set_header X-Forwarded-Proto \$scheme;
    proxy_set_header X-Forwarded-Host \$http_host;
    proxy_redirect off;
  }


  access_log            ${_LOGS}/nginx/jackett.${_DNS_NAME}.access.log combined;
  error_log             ${_LOGS}/nginx/jackett.${_DNS_NAME}.error.log;
}
EOT

file { "/etc/nginx/sites-enabled/jackett.${_DNS_NAME}":
  ensure  => file,
  content => $jackett_reverse_proxy,
  owner   => 'root',
  group   => 'root',
  mode    => '0644',
}
