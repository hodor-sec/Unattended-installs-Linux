class diskresize {
  exec { 'disk_resize':
    command => 'resize2fs -F -p /dev/sda1',
    path    => ['/usr/bin', '/usr/sbin',],
  }
}
