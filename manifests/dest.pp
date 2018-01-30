define squidguard::dest (
  String $destname      = $title,
  $domainlist           = [],
  $urllist              = [],
  $expressionlist       = [],
  Optional[String] $log = undef,
  String $order         = '02',
) {

  concat::fragment{"squidguard_dest_${destname}":
    target  => $::squidguard::configfile,
    content => template('squidguard/squidguard.conf.dest.erb'),
    order   => "30-${order}-${destname}",
  }

}
