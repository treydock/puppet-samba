class samba::server inherits samba {

	include concat::setup

    package { [ "$samba_package", "$samba_client_package", "$samba_common_package", "$samba_winbind_package" ] :
            ensure      => installed,
    }

    file {
        "$samba_config_dir":
            ensure      => directory,
            owner       => root,
            group       => root,
            mode        => 755,
            require		=> Package["$samba_package"];

        "$samba_config":
			ensure		=> present,
            owner       => root,
            group       => root,
            mode        => 644,
            content 	=> template("samba/smb_conf.erb"),
            require 	=> File["$samba_config_dir"],
			notify		=> Service['smb'];

        "/etc/nsswitch.conf":
			ensure		=> present,
            owner       => root,
            group       => root,
            mode        => 644,
            source	 	=> "puppet:///modules/samba/$nss_config";

        "/etc/pam.d/samba":
			ensure		=> present,
            owner       => root,
            group       => root,
            mode        => 644,
            source	 	=> "puppet:///modules/samba/pam-samba";

        "/etc/pam.d/password-auth-ac":
			ensure		=> present,
            owner       => root,
            group       => root,
            mode        => 644,
            #source	 	=> "puppet:///modules/samba/pam-password-auth-ac";
            content	 	=> template('samba/password_auth_ac.erb');

		'/var/lock/samba':
			ensure	=> directory,
			owner	=> 'root',
			group	=> 'root';

        "/etc/krb5.conf":
			ensure		=> present,
            owner       => root,
            group       => root,
            mode        => 644,
            source	 	=> "puppet:///modules/samba/krb5.conf";

        }


    service {
        "smb":
            enable		=> true,
            ensure      => running,
            hasstatus   => true,
            hasrestart  => true,
            require     => [ Package["$samba_package"], File["$samba_config"] ];
        "winbind":
            enable		=> true,
            ensure      => running,
            hasstatus   => true,
            hasrestart  => true,
            require     => [ Package["$samba_winbind_package"], File["$samba_config"] ];
    }

	concat {"${samba::samba_config_dir}/shares.conf":
    	owner  	=> 'root',
    	group  	=> 'root',
		mode	=> '644',
		notify	=> [ Service['smb'] ], #, Service['winbind'] ],
  	}
}
