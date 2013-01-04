class gvim {
	case $operatingsystem {
		debian, ubuntu: {
			package { "vim-gtk":
				ensure => present,
				before => File[gvimrc],
			}
		}

		centos, redhat, fedora: {
			package { "vim-X11":
				ensure => present,
				before => File[gvimrc],
			}
		}
	}

	file { "gvimrc":
		ensure => present,
		path => "$USER_DIR/.gvimrc",
		source => "$PUPPET_DIR/modules/gvim/files/gvimrc",
		owner => "$USER", group => "$USER", mode => 0644,
	}

}
