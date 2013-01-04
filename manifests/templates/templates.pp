Exec {
    path => "/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin",
}

node core {
	include vim
	include bash
}

node server inherits core {
	include apache2
}

node mediaserver inherits core {
	include subsonic
}

node gui inherits core {
	include i3-wm
	include chromium
	include firefox
}

node desktop inherits gui {
	include vlc
}

node dev inherits desktop {
	include gvim
}
