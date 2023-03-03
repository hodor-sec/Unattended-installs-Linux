# Vagrant
Templates for deploying VM's using Vagrant and provisioning using Puppet.

### Install prerequisites:
```
vagrant plugin install vagrant-vbguest
vagrant plugin install vagrant-puppet-install
puppet module install puppetlabs-apt
```

### Create / destroy VM
```
vagrant up --provision
vagrant destroy -f
```

## Debian Virtualbox
Installs Debian x64 Testing using several selected packages as described in the modules directory.