class samba::commands {

	exec { 'test_ad_join':
		command		=> '/usr/bin/net ads testjoin | grep --quiet OK',
		user		=> 'root',
		cwd			=> '/var/lib/samba',
		refreshonly	=> true,
		require		=> [ Package["$samba_common_package"] ],
	}

}
