class tmuxconfig {
    include tmuxconfig::download, tmuxconfig::config    
}

class tmuxconfig::download {
  # Download git project to /opt
  exec { 'tmuxconfig_create_dir':
    	command => 'mkdir -p /etc/skel/.tmux_custom',
    	path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'tmuxconfig_download_git':
    	command => 'git clone https://github.com/hodor-sec/.tmux.git /etc/skel/.tmux_custom',
    	path    => ['/usr/bin', '/usr/sbin',],
  }
}

class tmuxconfig::config {
    # Create symlink
    exec { 'create_symlink':
        command => "ln -sf /etc/skel/.tmux_custom/.tmux.conf /etc/skel/.tmux.conf",
        path    => ['/usr/bin', '/usr/sbin',],
    }
    # Copy custom config file to home directory
    file { "/etc/skel/.tmux.conf.local":
   	    ensure => present,
   	    source => 'puppet:///modules/tmuxconfig/.tmux.conf.local',
    }
}
