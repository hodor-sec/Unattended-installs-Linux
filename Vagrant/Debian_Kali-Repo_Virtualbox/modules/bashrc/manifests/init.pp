class bashrc {
    include bashrc::config
}

class bashrc::config {
    # Copy custom config file to home directory
    file { "/etc/skel/.bashrc":
        ensure => present,
        source => 'puppet:///modules/bashrc/.bashrc',
    }
}

