class diskresize {
  exec { 'disk_resize':
    command => 'resize2fs -p -F /dev/sda1',
    path    => ['/usr/bin', '/usr/sbin',],
  }
}
