class timezone {
	exec { "set-timezone":
        	user => root,
        	group => root,
        	command => '/usr/bin/timedatectl set-timezone Europe/Amsterdam',
    	}

	exec { 'reconfigure-tzdata':
        	user => root,
        	group => root,
        	command => '/usr/sbin/dpkg-reconfigure --frontend noninteractive tzdata',
	}

}
