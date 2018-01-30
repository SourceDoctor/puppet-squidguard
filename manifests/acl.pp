define squidguard::acl (
  String $aclname = $title,
  $ruleset        = undef,
  String $order   = '05',
) {

  concat::fragment{"squidguard_acl_${aclname}":
    target  => $::squidguard::configfile,
    content => template('squidguard/squidguard.conf.acl.erb'),
    order   => "60-${order}-${aclname}",
  }

}
