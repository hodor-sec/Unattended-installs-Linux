class packages {
    include packages::tools, packages::kali
}

class packages::preinstall {
    package { [
        'git',
        'gnupg',
    ]:
    ensure => present
    }
}

class packages::tools {
    package { [
      'ack-grep',
      'aha',
      'aptitude',
      'build-essential',
      'curl',
      'dnsutils',
      'gawk',
      'golang',
      'htop',
      'locate',
      'lsof',
      'module-assistant',
      'nasm',
      'netcat-traditional',
      'ncat',
      'net-tools',
      'nmap',
      'openssl',
      'p7zip-full',
      'python3',
      'puppet',
      'ripgrep',
      'screen',
      'tmux',
      'tree',
      'sed',
      'strace',
      'sudo',
      'vim',
      'virtualbox-guest-x11',
      'wget',
      ]:
      ensure  => present
    }
}

class packages::kali {
    package { [
        'kali-linux-default',
        'metasploit-framework',
        'seclists',
    ]:
    ensure => present
    }
}
