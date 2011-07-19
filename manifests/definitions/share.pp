define samba::share (
  	$netmask=false,
	$range_start=false,
	$range_end=false,
  	$router=false,
	$domain_name=false,
	$dns_servers=false,
	$pxe_only=false,
  	$pxe_opts=false) {

	include samba::params

# TODO: use concatfilepart to add include line to sambad.conf rather than statically set path
#	common::concatfilepart {"samba.${name}":
#    	file => "${samba::params::samba_config_dir}/sambad.conf",
#    	ensure => $ensure,
#    	content => "include \"${samba::params::samba_config_dir}/subnets/${name}.conf\";\n",
#  	}

#	file {"${samba::params::samba_config_dir}/subnets/${name}.conf":
	file {"${samba::params::samba_config_dir}/subnets/local.conf":
    	ensure 	=> present,
    	owner  	=> 'root',
    	group  	=> 'root',
    	content => template("samba/subnet_conf.erb"),
    	notify  => Service["sambad"],
  	}
}

