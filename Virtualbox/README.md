# Virtualbox scripts
Contains scripts for deploying Debian VM's for Virtualbox.

### Remarks
Shown scripts contain shell wrappers for mainly the "vboxmanage" command.
Default installed with XFCE4 GUI and installed with Virtualbox Guest Additions. Minimally installed with some in script coded tools, attempted to make the scripts a bit user- and modification-friendly, as far as the horrendous Bash scripting language allows it.
A bit of scripting was performed to actually make the Virtualbox Guest Additions work, instead of the erroneous --install-additions option for "vboxmanage" which halt and returns an error during unattended installs.

## Default credentials
For both user root and vbox, use password 'changeme'. That does mean you should change the password :)

### create_debian_or_kali_x64_vm.sh
Script for deploying a Debian Testing or Kali Rolling release, based on it's repositories. Might take some time due to the "kali-linux-default" packages install.

### create_debian_stable_or_testing_x64_vm.sh
Script for deploying a Debian Stable or Testing release, based on the downloaded ISO image.

