#!/usr/bin/env bash
#	Keeping it portable.
#	see:	https://www.cyberciti.biz/tips/finding-bash-perl-python-portably-using-env.html

echo	"╔═══════════════════════════════════════════════════════════════════════╗"
echo	"║ Ubuntu 20.04 Desktop Deployment Scropt                                ║"
echo	"║ © 2021 Kevin Karhan   -  k.karhan@compay.de                           ║"
echo	"║ made for Compay       -  https://compay.de/                           ║"
echo 	"║ licensed under GPLv3                                                  ║"
echo	"╠═══════════════════════════════════════════════════════════════════════╣"
echo 	"║ USE ON YOUR OWN RISK! THE AUTHOR IS NOT LIABLE FOR ANY DAMAGES!       ║"
echo	"╟───────────────────────────────────────────────────────────────────────╢"
echo	"║ PREPARE FOR FORESEEABLE CONSEQUENCES! ~ YOU HAVE BEEN WARNED!         ║"
echo	"╚═══════════════════════════════════════════════════════════════════════╝"

echo 	"update preroll..."
sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get autoclean
echo	"installing necessary dependencies..."
sudo apt install snapd wget curl

echo	"installing enpass..."
echo "deb https://apt.enpass.io/ stable main" > /etc/apt/sources.list.d/enpass.list
wget -O - https://apt.enpass.io/keys/enpass-linux.key | apt-key add -
sudo apt update && sudo apt-get install enpass 

echo	"installing anydesk..."
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | apt-key add -
echo "deb http://deb.anydesk.com/ all main" > /etc/apt/sources.list.d/anydesk-stable.list
apt update && apt install anydesk

echo	"installing mattermost..."
sudo snap install mattermost-desktop

echo	"installing linphone..."
sudo apt-get install linphone 

echo	"installing zulip..."
sudo snap install zulip

echo	"installing shutter..."
sudo snap install shutter

echo	"installing color picker..."
sudo snap install pick-colour-picker

echo	"installing vscodium..."
wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg | gpg --dearmor | sudo dd of=/etc/apt/trusted.gpg.d/vscodium.gpg 
echo 'deb https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs/ vscodium main' | sudo tee --append /etc/apt/sources.list.d/vscodium.list 
sudo apt update && sudo apt install codium 

echo	"installing vlc..."
sudo apt install vlc

echo	"installing remmina..."
sudo apt install remmina

echo	"installing synaptic..."
sudo apt install synaptic

echo	"installing window shuffler..."
sudo apt install budgie-window-shuffler

echo	"installing vpn..."
sudo apt install openvpn* network-manager-openvpn* network-manager-ssh 

echo	"installing SSH"
sudo apt install openssh-client openssh-server

echo	"purging unsafe bs..."
sudo apt-get purge pptp* network-manager-pptp*

echo	"final cleanup"
sudo apt-get update && sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get autoclean


echo    " "
echo    "finished!"
echo    "Do you wish to reboot the system?"
#   reboot question

select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "rebooting"; break;;
		No ) echo "done"; exit;;
    esac
done

sudo reboot && exit 
