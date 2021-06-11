#!/bin/bash
#
# Post-install script for Ubuntu 20.04
#

echo '-------- Post-install script Ubuntu --------'

echo 'Setting aliases'
echo 'Setting alias rm=rm -i'
alias rm=rm -i

# set linux time to local if dual booting Windows
if (awk -F\' '/menuentry / {print $2}' /boot/grub/grub.cfg  | grep 'Windows Boot Manager'); then 
    echo "Windows Boot Manager found"
    echo "Setting linux time to local"
    timedatectl set-local-rtc 1
fi

# apt install programs
echo 'Installing APT packages'
APT_INSTALL_LIST='tree vim python3-pip git nodejs npm'
sudo apt install $APT_INSTALL_LIST -y
echo 'APT packages installed'

# install snap packages
echo 'Installing Snap packages'
sudo snap install --classic code
echo 'Snap packages installed'

# install python modules
echo 'Installing PIP modules'
PIP_LIST='pandas numpy networkx sklearn spacy flask requests plotly jupyter notebook pillow seaborn'
pip install wheel # make sure wheel is installed
pip install $PIP_LIST
echo 'PIP modules installed'

echo 'Post-install finished'
echo 'If Ubuntu is being dual booted with Windows, but not added to Grub, do not forget to set time to local in order to sync time in both systems'
