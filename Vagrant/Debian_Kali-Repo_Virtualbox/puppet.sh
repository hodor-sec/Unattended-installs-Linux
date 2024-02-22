#!/bin/sh
command -v puppet > /dev/null && { echo "Puppet is installed! skipping" ; exit 0; }

ID=$(cat /etc/os-release | awk -F= '/^ID=/{print $2}' | tr -d '"')
VERS=$(cat /etc/os-release | awk -F= '/^VERSION_ID=/{print $2}' | tr -d '"')

case "${ID}" in
  centos|rhel)
    wget https://yum.puppet.com/puppet7/puppet8-release-el-${VERS}.noarch.rpm
    rpm -Uvh puppet8-release-el-${VERS}.noarch.rpm
    yum install -y puppet-agent
    ;;
  fedora)
    rpm -Uvh https://yum.puppet.com/puppet7/puppet8-release-fedora-${VERS}.noarch.rpm
    yum install -y puppet-agent
    ;;
  debian|ubuntu)
    # wget https://apt.puppetlabs.com/puppet7-release-$(lsb_release -cs).deb
    # dpkg -i puppet7-release-$(lsb_release -cs).deb
    wget https://apt.puppetlabs.com/puppet8-release-bullseye.deb
    dpkg -i puppet8-release-bullseye.deb
    apt-get -qq update
    apt-get install -y puppet-agent
    ;;
  *)
    echo "Distro '${ID}' not supported" 2>&1
    exit 1
    ;;
esac
