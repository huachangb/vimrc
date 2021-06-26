#!/bin/bash
#
# Post-install script for Ubuntu 20.04
#

echo '-------- Post-install script Ubuntu --------'

echo 'Setting aliases'
echo 'Setting alias rm=rm -i'
alias rm='rm -i'

echo 'Updating packages'
sudo apt install && sudo apt upgrade

# sudo  update-grub

# set linux time to local if dual booting Windows
if (awk -F\' '/menuentry / {print $2}' /boot/grub/grub.cfg  | grep 'Windows Boot Manager'); then 
    echo "Windows Boot Manager found"
    echo "Setting linux time to local"
    timedatectl set-local-rtc 1
fi

# codecs for mp* etc
# echo 'Installing codecs'
# sudo apt install ubuntu-restricted-extras

# apt install programs
echo 'Installing APT packages'
wget https://raw.githubusercontent.com/huachangb/setup-pc/main/apt_packages.txt
xargs -a apt_packages.txt sudo apt install
echo 'Apt packages installed'
echo 'Removing apt packages text file'
rm -f apt_packages.txt

# install snap packages
echo 'Installing Snap packages'
sudo snap install --classic code
echo 'Snap packages installed'

# install python modules
echo 'Installing PIP modules'

# make sure wheel is installed for faster pip installs
if ! pip list | grep wheel; then
	echo "Installing wheel"
	pip install wheel
fi

# download and install list of modules
wget https://raw.githubusercontent.com/huachangb/setup-pc/main/python_modules.txt
pip install -r python_modules.txt
echo 'PIP modules installed'
echo 'Removing modules text file'
rm -f python_modules.txt

echo 'Post-install finished'
echo 'If Ubuntu is being dual booted with Windows, but not added to Grub, do not forget to set time to local in order to sync time in both systems'
