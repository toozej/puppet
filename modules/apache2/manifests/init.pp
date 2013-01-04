class apache2 {

    case $operatingsystem {
        debian, ubuntu: {
            package { "apache2":
                ensure => present,
                before => File["toozej.conf"];
            }

            file { "toozej.conf":
                path => "/etc/apache2/sites-enabled/toozej.conf",
                source => "$PUPPET_DIR/modules/apache2/files/etc/apache2/sites-enabled/toozej.conf",
                owner => "root", group => "root", mode => 0644,
                require => Package['apache2'];
            }

            file { "/etc/apache2/sites-available/default":
                ensure => absent;
            }
            file { "/etc/apache2/sites-available/default-ssl":
                ensure => absent;
            }
            file { "/etc/apache2/sites-enabled/000-default":
                ensure => absent,
                require => [
                    File['/etc/apache2/sites-available/default'],
                    File['/etc/apache2/sites-available/default-ssl']
                ];
            }

            exec {
                'a2enmod rewrite':
                onlyif => 'test ! -e /etc/apache2/mods-enabled/rewrite.load';
                'a2enmod proxy':
                onlyif => 'test ! -e /etc/apache2/mods-enabled/proxy.load';
                'a2enmod userdir':
                onlyif => 'test ! -e /etc/apache2/mods-enabled/userdir.load';
            }

            service { "apache2":
                ensure => running,
                enable => true,
                require => Package['apache2'],
                subscribe => [
                    File['toozej.conf'],
                    File['/etc/apache2/sites-enabled/000-default'],
                ];
            }
        }
    }

}
