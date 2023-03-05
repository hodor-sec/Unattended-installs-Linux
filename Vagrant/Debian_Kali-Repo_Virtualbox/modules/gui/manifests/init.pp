class gui {
    package { [
      'xfce4-*',
      'firefox-esr',
      'chromium',
      'bleachbit',
      'gparted',
      'gnome-backgrounds',
      'network-manager-*',
      ]:
      ensure  => present
    }
}
