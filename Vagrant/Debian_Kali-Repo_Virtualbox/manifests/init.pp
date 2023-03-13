node default {
    include bashrc
    include packages::preinstall
    include tmuxconfig
    include users
    include vimconfig
    include sudoers
    include kali_apt
    include packages
    include ssh
    include gui
}
