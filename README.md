Puppet module for SquidGuard
============================

[![Build Status](https://travis-ci.org/SourceDoctor/puppet-squidguard.png?branch=master)](https://travis-ci.org/SourceDoctor/puppet-squidguard)

Description
-----------

Puppet module for configuring squidGuard URL Rewrite.

## Supported distributions
 - Debian (Jessie and later)
 - Ubuntu (Trusty and later)

Dependencies
============

 - Squid Proxy Cache


To get all Features and rules check SquidGuard Homepage

[Basic Settings](http://www.squidguard.org/Doc/configure.html)

[Extended Settings](http://www.squidguard.org/Doc/extended.html)

Usage
-----

The set up a simple squidguard configuration
with pass through all requests

```puppet
class { 'squidguard': }
squidguard::acl { 'default':
  ruleset => ['pass all'],
}
```

would result in squidguard.conf

```
acl {
    default {
        pass all
    }
}
```

### Define a Source Rule squidguard::src

```puppet
squidguard::src { 'grownups':
   ip     => ['1.2.3.4/24',
              '2.3.4.10-2.3.4.100'],
   domain => ['example.org',
              'example.com'],
   user   => ['user1', 'user2', 'user3'],
}
```

would result in squidguard.conf

```
src grownups {
    ip	   1.2.3.4/24
    ip	   2.3.4.10-2.3.4.100
    domain example.org
    domain example.com
    user   user1 user2 user3
}
```

### Define a Destination Rule squidguard::dest

```puppet
squidguard::dest { 'blocked':
   domainlist => ['blocked/domains',
                  'otherblocked/domains'],
   urllist    => ['blocked/urllist',
                 'customblocked/urls'],
}
```

would result in squidguard.conf

```
dest blocked {
    domainlist blocked/domains
    domainlist otherblocked/domains
    urllist    blocked/urllist
    urllist    customblocked/urls
}
```

### Define a Time Rule squidguard::time

```puppet
squidguard::time { 'leisure-time':
    weekly => ['* 00:00-08:00 17:00-24:00	# night and evening',
               'fridays 16:00-17:00		# weekend'],
    date   => ['*.01.01				# New Year's Day',
               '*.05.01				# Labour Day',
               '*.05.17				# National Day',
               '*.12.24 12:00-24:00		# Christmas Eve',
               '*.12.25				# Christmas Day',
               '*.12.26				# Boxing Day',
               '1999.03.31 12:00.24:00		# Ash Wednesday',
               '1999.04.01-1999.04.05		# Easter',
               '2000.04.19 12:00.24:00		# Ash Wednesday y2000',
               '2000.04.20-2000.04.24		# Easter y2000'],
}
```

would result in squidguard.conf

```
time leisure-time {
    weekly * 00:00-08:00 17:00-24:00	# night and evening
    weekly fridays 16:00-17:00		# weekend
    date	*.01.01				# New Year's Day
    date	*.05.01				# Labour Day
    date	*.05.17				# National Day
    date	*.12.24 12:00-24:00		# Christmas Eve
    date	*.12.25				# Christmas Day
    date	*.12.26				# Boxing Day
    date	1999.03.31 12:00.24:00		# Ash Wednesday
    date	1999.04.01-1999.04.05		# Easter
    date	2000.04.19 12:00.24:00		# Ash Wednesday y2000
    date	2000.04.20-2000.04.24		# Easter y2000
}
```

### Define a more complex acl Rule squidguard::acl

```puppet
squidguard::acl { 'grownups within leisure-time':
    ruleset => ['pass all				# don't censor peoples leisure-time'],
}
squidguard::acl { 'else':
    ruleset => ['pass !in-addr !porn all		# restrict access during business hours'],
}
squidguard::acl { 'kids':
    ruleset => ['pass !porn all			# protect the kids 24h anyway'],
}
squidguard::acl {'default':
    ruleset => ['pass none				# reject unknown clients',
                'redirect http://info.foo.bar/cgi/blocked?clientaddr=%a&clientname=%n&clientuser=%i&clientgroup=%s&targetgroup=%t&url=%u'],
}
```

would result in squidguard.conf

```
acl {
	grownups within leisure-time {
	    pass all				# don't censor peoples leisure-time
	}
    else {
	    pass !in-addr !porn all		# restrict access during business hours
	}

	kids {
	    pass !porn all			# protect the kids 24h anyway
	}

	default {
	    pass none				# reject unknown clients
	    redirect http://info.foo.bar/cgi/blocked?clientaddr=%a&clientname=%n&clientuser=%i&clientgroup=%s&targetgroup=%t&url=%u
	}
}
```

