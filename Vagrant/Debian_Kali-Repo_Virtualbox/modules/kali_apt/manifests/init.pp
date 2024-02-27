class kali_apt {
  exec { 'echo_kali':
    command => "echo 'deb http://http.kali.org/kali kali-rolling main non-free non-free-firmware contrib' > /etc/apt/sources.list",
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'echo_kali-src':
    command => "echo 'deb-src http://http.kali.org/kali kali-rolling main non-free non-free-firmware contrib' >> /etc/apt/sources.list",
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'apt_update':
    command => 'apt-get -q -y -o Dpkg::Options::="--force-confold" update',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'grub_debconf':
    command => 'printf "%s\n" "grub-pc grub-pc/install_devices multiselect /dev/sda" | debconf-set-selections',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'grub_install':
    command => 'grub-install /dev/sda && update-grub',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'apt_grub':
    command => 'apt-get -q -y -o Dpkg::Options::="--force-confold" install grub2',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'apt_upgrade':
    command => 'apt-get -q -y -o Dpkg::Options::="--force-confold" upgrade',
    path    => ['/usr/bin', '/usr/sbin',],
    timeout => 0,
  }
  exec { 'apt_dist-upgrade':
    command => 'apt-get -q -y -o Dpkg::Options::="--force-confold" dist-upgrade',
    path    => ['/usr/bin', '/usr/sbin',],
    timeout => 0,
  }
}
