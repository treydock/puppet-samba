class samba {
	
    $samba_config_dir = $operatingsystem ? {
		'CentOS'	=> "/etc/samba",
		default		=> "/etc/samba",
	}

	$samba_package = $operatingsystemrelease ? {
		/5.(\d)/	=> 'samba3x',
		/6.(\d)/	=> 'samba',
	}

	$samba_client_package = $operatingsystemrelease ? {
		/5.(\d)/	=> 'samba3x-client',
		/6.(\d)/	=> 'samba-client',
	}

	$samba_common_package = $operatingsystemrelease ? {
		/5.(\d)/	=> 'samba3x-common',
		/6.(\d)/	=> 'samba-common',
	}

	$samba_winbind_package = $operatingsystemrelease ? {
		/5.(\d)/	=> 'samba3x-winbind',
		/6.(\d)/	=> 'samba-winbind',
	}

	$nss_config = $operatingsystemrelease ? {
		/5.(\d)/	=> 'nsswitch.conf',
		/6.(\d)/	=> 'nsswitch.conf.centos6',
	}

	$samba_config = "$samba_config_dir/smb.conf"
	$samba_share_file = "$samba_config_dir/shares.conf"
}
