# Vagrant
Templates for deploying VM's using Vagrant and provisioning using Puppet.

### Install prerequisites:

Packages:
```
sudo apt install vagrant puppet
```

Plugins:
```
vagrant plugin install vagrant-puppet-install
puppet module install puppetlabs-apt
```

### Create / destroy VM

Navigate to directory containing 'Vagrantfile'

```
vagrant up --provision
vagrant destroy -f
```

## Debian Virtualbox
Installs Debian x64 Testing using several selected packages as described in the modules directory.
Uses custom commands for install Virtualbox Guest Additions, as Vagrant version is quite old.
