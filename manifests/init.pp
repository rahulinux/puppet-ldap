# TODO
# - Install ldap-server package base on OS

class ldap::install {

	package { $ldap::params::ldap_package_name:
	
		ensure => installed,

	}
}

class ldap::config {

	file { $ldap::params::ldap_env_file:
		content => template("ldap/ldap.conf.erb"), 
	}

	file { "/opt/ldif":
		ensure => directory,
		mode => '0744',
	}

	file { "/opt/ldif/slapd.conf.tmp":
		 content => template($ldap::params::slapd_sample),
	}
	
	file { "/opt/ldif/root.ldif" :
		content => template("ldap/root.ldif"),
	}

}


class ldap(
	  $organization,
	  $commonname,
	  $domain_name,
	  $uri,        
	  $base,      
	  $ssl	= false,  
	  $rootpw,
	  $sslcert,
	  $backend,
	
) {

if($ssl)
  {
    $port = 636
    $real_uri = "ldaps://${uri}"
}
else
  {
    $port = 389
    $real_uri = "ldap://${uri}"
}
 
include ldap::params, ldap::install, ldap::config, ldap 

}
