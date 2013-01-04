class subsonic {

	case $operatingsystem {	
		debian, ubuntu: {

			package { "openjdk-6-jre":
				ensure => installed,
			}

			exec { "subsonic_download":
				command => "wget http://downloads.sourceforge.net/project/subsonic/subsonic/4.7/subsonic-4.7.deb",
				require => Package["openjdk-6-jre"],
				unless => "cat /etc/default/subsonic > /dev/null";
			}

			exec { "subsonic_install":
				command => "dpkg -i subsonic-4.7.deb",
				require => Exec["subsonic_download"],
				unless => "cat /etc/default/subsonic > /dev/null";
			}

			exec { "subsonic_remove":
				command => "rm -r subsonic-4.7.deb",
				require => Exec["subsonic_install"],
				unless => "cat /etc/default/subsonic > /dev/null";
			}

			service { "subsonic":
				ensure => running,
				require => [
					Exec['subsonic_install']
				];
			}
		}
		
		centos, redhat, fedora: {

			package { "java-1.6.0-openjdk":
				ensure => installed,
			}

			exec { "subsonic_download":
				command => "wget http://downloads.sourceforge.net/project/subsonic/subsonic/4.7/subsonic-4.7.rpm",
				require => Package["java-1.6.0-openjdk"],
				unless => "cat /etc/default/subsonic > /dev/null";
			}

			exec { "subsonic_install":
				command => "sudo yum install --nogpgcheck subsonic-4.7.rpm",
				require => Exec["subsonic_download"],
				unless => "cat /etc/default/subsonic > /dev/null";
			}

			exec { "subsonic_remove":
				command => "rm -r subsonic-4.7.rpm",
				require => Exec["subsonic_install"],
				unless => "cat /etc/default/subsonic > /dev/null";
			}

			service { "subsonic":
				ensure => running,
				require => [
					Exec['subsonic_install']
				];
			}
		}
	}
}
