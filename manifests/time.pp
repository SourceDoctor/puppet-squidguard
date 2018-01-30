define squidguard::time (
  String $timename = $title,
  $weekly          = undef,
  $date            = undef,
  String $order    = '02',
) {

  concat::fragment{"squidguard_time_${timename}":
    target  => $::squidguard::configfile,
    content => template('squidguard/squidguard.conf.time.erb'),
    order   => "40-${order}-${timename}",
  }

}
