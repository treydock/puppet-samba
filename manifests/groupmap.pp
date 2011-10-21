define samba::groupmap (
	ntgroup=false,
	type=false,
	gid=false


) {


	group { "$name":
		ensure	=> present,
		gid		=> $gid ? {
				false	=> undef,
				default	=> $gid,
		},
		system	=> false,
	}

	exec { 'set_groupmap':
		command		=> "/usr/bin/net groupmap add ntgroup=${ntgroup} unixgroup=${name} type=${type}",
		onlyif		=> '/usr/bin/net ads testjoin | grep --quiet OK'
		unless		=> "/usr/bin/net groupmap list | grep --quiet ${name}"
		user		=> 'root',
		cwd			=> '/var/lib/samba',
		logoutput	=> true,
		require		=> [ Package["$samba_winbind_package", "$samba_common_package"] ],
	}


}
