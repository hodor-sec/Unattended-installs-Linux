node default {
    include kali_apt
    include packages
    include sudoers
    include bashrc
    include tmuxconfig
    include users
    include vimconfig
    include timezone
    include ssh
    include gui
}
