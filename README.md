Managing Samba with Puppet
=====================

This module is currently only intended to be used on nodes that need to be Active Directory domain members.

This module relies on [puppet-concat](https://github.com/ripienaar/puppet-concat).

This is a very rough draft and I am still in the process of making it work just right for my specific environment, but thought it may be of use to someone.

Usage 
============

Assign to node
---------------

The example below is a role I use to define similar samba servers in my environment, but the usage is the same for nodes.

```ruby
class role_samba_server {
	$concat_basedir="/usr/local/share/puppet"
	include concat::setup

	$workgroup = 'example.com'
	$realm = 'example.com'
	$primary_group = 'Domain Users'

	include samba::server
}
```

Share definition
--------------

Here's an example of a share definition.

```ruby
samba::share {
'example':
	path			=> '/var/www/example.com',
	writeable		=> 'yes',
	browseable		=> 'yes',
	invalid_users	=> 'root',
	valid_users		=> '@staff',
	create_mask		=> '664',
	dir_mask		=> '775';
}
```

AD Group Integration
--------------------

The password_auth_ac template for PAM grants access to a group that is hostname-access.  This is an example of one way to manage Linux access on a samba server.  In my Active Directory I create an access group for each server that is the first layer of control for all forms of access (File share and SSH).


To Do
======

* Convert to parameterized module
* Fully document all options
* Expand the server functions this samba conig can be used for
