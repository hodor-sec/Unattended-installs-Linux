class ssh {
    include ssh::install, ssh::config, ssh::service
  }

class ssh::install {
  package {"openssh-server":
    ensure => present,
    }
  }

class ssh::config {
  file { "/etc/ssh/sshd_config":
  ensure => present,
  owner => 'root',
  group => 'root',
  mode => '-rw------',
  source => "puppet:///modules/ssh/sshd_config",
  notify => Class["ssh::service"],
      }
  }

class ssh::service {
  service { "ssh":
    ensure => running,
    hasstatus => true,
    hasrestart => true,
    enable => true,
    }
  }
