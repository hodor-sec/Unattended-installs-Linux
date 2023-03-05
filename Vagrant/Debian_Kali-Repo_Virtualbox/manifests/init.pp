node default {
    include bashrc
    include tmuxconfig
    include sudoers
    include users
    include packages::preinstall
    include kali_apt
    include packages
    include ssh
    include gui
}
