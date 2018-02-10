define squidguard::src (
  String $srcname = $title,
  $ip             = [],
  $iplist         = [],
  $user           = [],
  $userlist       = [],
  $domain         = [],
  $execuserlist   = [],
  String $order   = '02',
) {

  concat::fragment{"squidguard_src_${srcname}":
    target  => $::squidguard::configfile,
    content => template('squidguard/squidguard.conf.src.erb'),
    order   => "20-${order}-${srcname}",
  }

}
