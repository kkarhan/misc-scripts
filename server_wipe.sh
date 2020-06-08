#!/usr/bin/env bash
#	Keeping it portable.
#	see:	https://www.cyberciti.biz/tips/finding-bash-perl-python-portably-using-env.html

echo	"╔═══════════════════════════════════════════════════════════════════════╗"
echo	"║ Linux Server Wiping Script                                            ║"
echo	"║ © 2020 Kevin Karhan   -  https://github.com/kkarhan/misc-scripts      ║"
echo	"║ made for JTL Software -  https://www.jtl-software.de/                 ║"
echo 	"║ licensed under GPLv3                                                  ║"
echo	"╠═══════════════════════════════════════════════════════════════════════╣"
echo 	"║ USE ON YOUR OWN RISK! THE AUTHOR IS NOT LIABLE FOR ANY DAMAGES!       ║"
echo	"╟───────────────────────────────────────────────────────────────────────╢"
echo	"║ PREPARE FOR FORESEEABLE CONSEQUENCES! ~ YOU HAVE BEEN WARNED!         ║"
echo	"╚═══════════════════════════════════════════════════════════════════════╝"

echo    " "
echo    "detecting devices..."
echo    " "

lsblk -e7 -d -io NAME -n

#	lists devices, excluding loopback devices partitions and header line.
#	see:	https://unix.stackexchange.com/questions/414305/lsblk-capture-only-the-disks
#	output should only yield /dev/ devicenames like sda & nvme0n1

echo    " "
echo    "All the detected drives will be overwritten multiple times irreversibly."
echo    " "
echo    "Do you wish to wipe these?"
#   Final explainer

select yn in "Yes" "No"; do
    case $yn in
        Yes ) echo "THERE IS NO TURNING BACK NOW!"; break;;
		No ) echo "ABORTED!"; exit;;
    esac
done
#   Yes/No security questiong

mapfile -t my_array < <(lsblk -e7 -d -io NAME -n)

for i in "${my_array[@]}"
do
    shred -f -n 1 -v -z /dev/$i
    echo    "/dev/$i nuked!"
    echo    " "
done

#   wipe each detected disk [physical block device] twice with shred & output progress

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
