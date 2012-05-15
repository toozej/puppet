$USER = "james"
$USER_DIR = "/home/james"
$PUPPET_DIR = "/home/james/puppet"

node "diatto" inherits laptop {
    include gnome
    include compiz
    include firefox
    include synapse
    include terminator
    include vlc
}
