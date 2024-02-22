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
    command => 'apt-get -y update',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'apt_upgrade':
    command => 'apt-get -y upgrade',
    path    => ['/usr/bin', '/usr/sbin',],
  }
  exec { 'apt_dist-upgrade':
    command => 'apt-get -y dist-upgrade',
    path    => ['/usr/bin', '/usr/sbin',],
  }
}
