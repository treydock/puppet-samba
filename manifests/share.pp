define samba::share (
  	$comment=false,
	$path=false,
	$public=false,
  	$writeable=false,
	$browseable=false,
	$invalid_users=false,
	$create_mask=false,
  	$dir_mask=false,
	$force_create_mode=false,
	$force_dir_mode=false,
	$inherit_acls=false,
	$write_list=false,
	$valid_users=false) {

	include concat::setup


	concat::fragment { "smb_share_$name":
		target	=> "${samba::samba_config_dir}/shares.conf",
		content	=> template('samba/smb_share_conf.erb'),
		order	=> 01,
	}

/*

	acls { id , mode , path => $path

	if not acls.empty? {

		include acl
		
		


	}


*/
}

