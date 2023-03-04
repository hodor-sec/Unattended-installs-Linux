class vimconfig {
    include vimconfig::download,vimconfig::config
}

class vimconfig::download {
  # Download git project to /opt
  exec { 'vimconfig_create-dir':
    	command => 'mkdir -p /opt/vim_custom',
    	path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'vimconfig_download_git':
    	command => 'git clone --depth=1 https://github.com/hodor-sec/vimrc.git /opt/vim_custom',
    	path    => ['/usr/bin', '/usr/sbin',],
  }
}

class vimconfig::config {
  exec { 'vimconfig_install_user':
    	command => 'sh /opt/vim_custom/install_awesome_parameterized.sh /opt/vim_custom --all',
    	path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'vimconfig_install_root':
    	command => 'sh /opt/vim_custom/install_awesome_parameterized.sh /opt/vim_custom root',
    	path    => ['/usr/bin', '/usr/sbin',],
  }
}

