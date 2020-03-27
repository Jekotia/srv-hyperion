class { 'ssh::server':
  storeconfigs_enabled => false,
  options => {
    'PasswordAuthentication' => 'no',
    'PermitRootLogin'        => 'no',
#    'Port'                   => [22, 2222],
  },
}

# https://www.linode.com/docs/security/using-fail2ban-for-security/
package { "fail2ban":          ensure        => "installed" }
