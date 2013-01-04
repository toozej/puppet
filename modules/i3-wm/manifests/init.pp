class i3-wm {

	package { "i3-wm":
		ensure => installed,
	}
	
	package { "i3lock":
		ensure => installed,
	}

	package { "i3status":
		ensure => installed,
	}

	file { "config":
		path => "$USER_DIR/.i3/config",
		source => "$PUPPET_DIR/modules/i3-wm/files/i3/config",
		owner => "$USER", group => "$USER", mode => 0644,
		require => [
			Package['i3-wm'],
			Package['i3lock'],
			Package['i3status'],
		]
	}


}
