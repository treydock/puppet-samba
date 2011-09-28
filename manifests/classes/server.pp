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
            owner       => root,
            group       => root,
            mode        => 644,
            content 	=> template("samba/smb_conf.erb"),
            require 	=> File["$samba_config_dir"],
			notify		=> Service['smb'];

        "/etc/nsswitch.conf":
            owner       => root,
            group       => root,
            mode        => 644,
            source	 	=> "puppet:///modules/samba/$nss_config";

        "/etc/pam.d/samba":
            owner       => root,
            group       => root,
            mode        => 644,
            source	 	=> "puppet:///modules/samba/pam-samba";

		'/var/lock/samba':
			ensure	=> directory,
			owner	=> 'root',
			group	=> 'root';
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
