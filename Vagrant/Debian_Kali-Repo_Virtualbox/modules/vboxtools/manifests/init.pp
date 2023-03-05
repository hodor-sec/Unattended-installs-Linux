class vboxtools {
  exec { 'install_iso':
    command => 'apt-get -y install virtualbox-guest-additions-iso',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'module_prepare':
    command => 'm-a prepare -i',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'create_dir':
    command => 'mkdir /tmp/vboxiso',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'extract_iso':
    command => '/usr/bin/7z x /usr/share/virtualbox/VBoxGuestAdditions.iso -o/tmp/vboxiso',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'run_script':
    command => 'sh /tmp/vboxiso/VBoxLinuxAdditions.run || true',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'delete_dir':
    command => 'rm -rf /tmp/vboxiso/',
    path    => ['/usr/bin', '/usr/sbin',],
  }
}
