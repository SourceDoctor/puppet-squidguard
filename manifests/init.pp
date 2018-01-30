class squidguard (

  String         $package_name  = $squidguard::params::package_name,
  String         $configfile    = $squidguard::params::configfile,
  String         $squid_user    = $squidguard::params::squid_user,
  String         $squid_group   = $squidguard::params::squid_group,
  String         $logdir        = $squidguard::params::logdir,
  String         $dbhome        = $squidguard::params::dbhome,
  String         $process_name  = $squidguard::params::process_name,
  String         $squid_binary  = $squidguard::params::squid_binary,

  Hash[String, Hash] $src       = {},
  Hash[String, Hash] $dest      = {},
  Hash[String, Hash] $time      = {},
  Hash[String, Hash] $acl       = {},

) inherits ::squidguard::params {

  anchor{'squidguard::begin':}
  -> class{'::squidguard::install':}
  -> class{'::squidguard::config':}
  -> anchor{'squidguard::end':}

}
