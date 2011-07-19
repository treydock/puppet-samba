/*

= Class: samba::params
Do NOT include this class - it won't do anything.
Set variables for names and paths

*/
class samba::params {
	
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
}
