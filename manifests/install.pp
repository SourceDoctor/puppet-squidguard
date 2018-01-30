# Class: squidguard::install

class squidguard::install  {

  package{$::squidguard::package_name:
    ensure  => present,
  }
}

