#!/bin/bash
#
# Post-install script for Ubuntu 20.04
#

echo '-------- Post-install script Ubuntu --------'
printf "Welcome\n\nThis is a post-install configuration script for Ubuntu 20.04\n"
echo ""

read -r -p "Are you dualbooting Windows?[y/n] " response
case "$response" in
	[yY][eE][sS]|[yY])
	     	echo "Set RTC time to local to prevent desyncing time with Windows\n"
		timedatectl set-local-rtc 1
		;;
	*)
esac
echo ""

echoThis() {
    # prints removeable chars to terminal
    echo -ne "Downloading and installing $1... \r"
}

GREEN="\033[0;32m"
NOCOLOR="\033[0m"

updateEchoThis() {
    # clears previous line and echoes message
    echo -ne "\e[K"
    echo -ne $GREEN
    echo -e "- Installed $1$NOCOLOR"
}

echo "Tasks:"
# update grub silently
{
    sudo update-grub
} &> /dev/null

UPDATE="system and package updates"
echoThis "$UPDATE"
{
    sudo apt -y update
    sudo apt -y upgrade
} &> /dev/null
updateEchoThis "$UPDATE"

APT="apt packages"
echoThis "$APT"
{
    wget https://raw.githubusercontent.com/huachangb/setup-pc/main/apt_packages.txt
    xargs -a apt_packages.txt sudo apt install
    rm -f apt_packages.txt
} &> /dev/null
updateEchoThis "$APT"

PIP_MODULES="python modules"
echoThis "$PIP_MODULES"
{
    # make sure wheel is installed for faster pip installs
    if ! pip list | grep wheel; then
        pip install wheel
    fi	

    download and install list of modules
    wget https://raw.githubusercontent.com/huachangb/setup-pc/main/python_modules.txt
    pip install -r python_modules.txt
    rm -f python_modules.txt
} &> /dev/null
updateEchoThis "$PIP_MODULES"

SNAP_PACKAGES="snap packages"
echoThis "$SNAP_PACKAGES"
{
    sudo snap install --classic code
} &> /dev/null
updateEchoThis "$SNAP_PACKAGES"

echo ""
echo "-------- Post-install script Ubuntu finished --------"
echo "Checklist"
echo "- Check if RTC time is set to local to sync time when dual booting"
echo "- Install VPN, Anaconda, Discord, Chrome and ubuntu set-up from your university/company"
