#!/usr/bin/env bash

if [ -f /etc/debian_version ] || [ grep -qi ubuntu /etc/lsb-release ]
then
    echo "INFO: Debian-based platform detected."
    echo "INFO: Install package requirements."
    sudo apt-get update -q && sudo apt-get install -y \
        build-essential \
        libssl-dev \
        libffi-dev \
        python \
        python-dev \
        python-setuptools
elif [ -f /etc/centos-release ] || [ -f /etc/redhat-release ]
then
    echo "INFO: RedHat-based platform detected."
    echo "INFO: Install package requirements."
    # code
else
    echo "ERROR: Unsupported platform."
    echo "Exiting.."
    exit 1
fi

echo "INFO: Install pip."
sudo easy_install pip

echo "INFO: Install Ansible."
sudo pip install --no-cache ansible==2.3.0.0
