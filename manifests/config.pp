class squidguard::config (
  $configfile   = $::squidguard::configfile,
  $squid_user   = $::squidguard::squid_user,
  $squid_group  = $::squidguard::squid_group,
  $logdir       = $::squidguard::logdir,
  $dbhome       = $::squidguard::dbhome,
  $process_name = $::squidguard::process_name,
  $squid_binary = $::squidguard::squid_binary,

  $src          = $::squidguard::src,
  $dest         = $::squidguard::dest,
  $time         = $::squidguard::time,
  $acl          = $::squidguard::acl,
) inherits squidguard {


  file {$logdir:
    ensure => directory,
    owner  => $squid_user,
    group  => $squid_group,
  }

  file {$dbhome:
    ensure  => directory,
    owner   => $squid_user,
    group   => $squid_group,
    recurse => true,
    notify  => Exec['squidguard_update_db']
  }

  concat{$configfile:
    ensure => present,
    owner  => $squid_user,
    group  => $squid_group,
    mode   => '0640',
    notify => Exec['squidguard_update_db']
  }

  concat::fragment{'squidguard_header':
    target  => $configfile,
    content => template('squidguard/squidguard.conf.header.erb'),
    order   => '01',
  }

  if $src {
    create_resources('squidguard::src', $src)
  }

  if $dest {
    create_resources('squidguard::dest', $dest)
  }

  if $time {
    create_resources('squidguard::time', $time)
  }

  if $acl {
    concat::fragment{'squidguard_acl_head':
      target  => $configfile,
      content => template('squidguard/squidguard.conf.acl_head.erb'),
      order   => '50-acl_head',
    }

    create_resources('squidguard::acl', $acl);

    concat::fragment{'squidguard_acl_foot':
      target  => $configfile,
      content => template('squidguard/squidguard.conf.acl_foot.erb'),
      order   => '70-acl_foot',
    }
  }

  exec {'squidguard_update_db':
    command     => "${process_name} -c ${configfile} -C all",
    refreshonly => true,
    notify      => Exec['squid_refresh']
  }

  exec {'squid_refresh':
    command     => "${squid_binary} -k reconfigure",
    refreshonly => true,
  }
}
