# Class: squidguard::params
#
# This class manages SquidGuard parameters

class squidguard::params {

  case $::operatingsystem {
    /^(Debian|Ubuntu)$/: {
      case $::operatingsystemrelease {
        default: {
          $package_name  = 'squidguard'
          $configfile    = '/etc/squidguard/squidGuard.conf'
          $logdir        = '/var/log/squidguard'
          $dbhome        = '/etc/squidguard/db'

          $process_name  = '/usr/bin/squidGuard'
          $squid_binary  = '/usr/sbin/squid'
        }
      }

      $squid_user        = 'squid'
      $squid_group       = 'squid'
    }
    default: {
      $package_name      = 'squidguard'
      $configfile        = '/etc/squidguard/squidGuard.conf'
      $logdir            = '/var/log/squidguard'
      $dbhome            = '/etc/squidguard/db'

      $process_name      = '/usr/bin/squidGuard'
      $squid_binary      = '/usr/sbin/squid'

      $squid_user        = 'squid'
      $squid_group       = 'squid'
    }
  }
}
