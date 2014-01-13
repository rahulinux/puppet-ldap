class ldap::params {

        # Common params
        $ldap_service_name = 'slapd'

        # os specific params
        case $operatingsystem {

                /(Ubuntu|Debian)/: {

                        $ldap_package_name = [ 'slapd', 'ldap-utils' ]
                        $ssldir = '/etc/ssl/ldap/'
                        $ldap_env_file = "/etc/ldap/ldap.conf"
			$slapd_sample = "ldap/slapd.conf.ubuntu"

                }

                /(Redhat|CentOS)/: {

                        
                        $ldap_package_name = [ 'openldap-servers', 'openldap-clients' ]
                        $ssldir = '/etc/pki/tls/certs'
                        $ldap_env_file = "/etc/openldap/ldap.conf"
			$slapd_sample = "ldap/slapd.conf.centos"
                }

                default: {
                        fail("Module ${module_name} is not supported on ${operatingsystem}")
                }


        }

}

