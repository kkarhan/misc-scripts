#!/usr/bin/env bash

#	Keeping it portable.
#	see:	https://www.cyberciti.biz/tips/finding-bash-perl-python-portably-using-env.html

echo	"	"
echo	"╔═══════════════════════════════════════════════════════════════════════╗"
echo	"║ Linux Network Diagnostic and Testing tool                             ║"
echo	"║ © 2021 Kevin Karhan                                k.karhan@compay.de ║"
echo	"║ made for Compay                                https://www.compay.de/ ║"
echo 	"║ licensed under GPLv3                                                  ║"
echo	"╠═══════════════════════════════════════════════════════════════════════╣"
echo 	"║ USE ON YOUR OWN RISK! THE AUTHOR IS NOT LIABLE FOR ANY DAMAGES!       ║"
echo	"╟───────────────────────────────────────────────────────────────────────╢"
echo	"║ The tool is provided >> as - is << without any warranties whatsoever! ║"
echo	"╚═══════════════════════════════════════════════════════════════════════╝"
echo	"	"
#	obligational header

echo	"	"
echo	"═════════════════════════════════════════════════════════════════════════"
echo	"Starting logfile..."
echo	"═════════════════════════════════════════════════════════════════════════"
echo	"	"

touch $HOME/net-analysis.log
#   creating logfile

{
#	Creating the log
#	see:	https://unix.stackexchange.com/questions/61931/redirect-all-subsequent-commands-stderr-using-exec/61932#61932

	echo	"	"
	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"logging started..."
	echo	"─────────────────────────────────────────────────────────────────────────"
	date
#	record date & time of start
	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"	"

	echo	"collecting basic system data..."
	echo	"	"
	screenfetch
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	hostname
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	hostname -A
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	hostname -a
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	hostname -f
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	hostname -i
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	hostname -I
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	hostname -y
#	checking detailed info on the system, with fallbacks in case screenfetch is not installed and/or to find different settings
	echo	"	"
	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"	"

	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"Collecting interface data..."
	echo	"	"
	ifconfig
#	ifconfig for the network interfaces
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	nmcli connection show
#	list active connections
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	nmcli device show
#	list devices
	echo	"	"

	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"determining public IP adresses..."
	curl ipinfo.io/ip
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	wget -qO- ipinfo.io/ip
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	lynx -source ipinfo.io/ip
#	determine public IP adress
#	see:	https://stackoverflow.com/questions/14594151/methods-to-detect-public-ip-address-in-bash#14594304
	echo	"	"

	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"collecting network statistics..."
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"...interfaces..."
	netstat -i
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"...routes..."
	netstat -p -W -r
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"...multicast groups..."
	netstat -g
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"...statistics..."
	netstat -s
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"...listening sockets"
	netstat -p -W -N -e -o -l
#	this should provide info on existing/open connections of the user.
	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"	"

	echo	"Running speedtests..."
	echo	"1/2"
	echo	"	"
	speedtest -v -s 32412 -b -P 8 -p no
#	This will add additional info and make the test repeatable in the first run.
#	Hardcoded server "3585" is from Leaseweb, located in Frankfurt a.M., Germany.
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"2/2"
	echo	"	"
	speedtest -vv -b -p no
#	This will ran another test using the "closest" server by ping.
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"checking proximity speedtesting servers"
	echo	"	"
	speedtest -L
#	OFC one could subsidize the proprietary Ookla Speedtest CLI [https://www.speedtest.net/apps/cli]
#	with the Librespeed CLI [https://github.com/librespeed/speedtest-cli],
#	This would certainly add value to the project
#	If one is interested to do so, feel free to do it & let me know about it!
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"

	echo	"pinging popular public DNS servers..."
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"Google"
	ping 8.8.8.8 -c 1 -D
#	Google DNS
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"Cloudflare"
	ping 1.1.1.1 -c 1 -D
#	Cloudflare DNS
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"Quad9"
	ping 9.9.9.9 -c 1 -D
#	Quad9 DNS
#	It may be intentional [or not] to have these fail.
#	Espechally when the network is configured to ban other DNS servers except the internal one for security reasons.
	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"	"
y
	echo	"pinging obscure DNS Servers..."
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"OpenNIC"
	ping 94.16.114.254 -c 1 -D
	ping 2a03:4000:28:365::1 -c 1 -D
#	OpenNIC	Server:	https://servers.opennic.org/edit.php?srv=ns9.de.dns.opennic.glue
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	ping ns1.fische.io -c 1 -D
#	OpenNIC	Server:	https://servers.opennic.org/edit.php?srv=ns21.de.dns.opennic.glue
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	ping 94.103.153.176 -c 1 -D
	ping 2a02:990:219:1:ba:1337:cafe:3 -c 1 -D
#	OpenNIC	Server:	https://servers.opennic.org/edit.php?srv=ns5.opennic.glue
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	ping okashi.me -c 1 -D
#	OpenNIC	Server:	https://servers.opennic.org/edit.php?srv=ns13.opennic.glue
	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"name.space"
	ping 72.69.161.7 -c 1 -D
	ping 72.69.161.13 -c 1 -D
#	Name.speace Servers:	http://namespace.us/opt-in.php
	echo	"═════════════════════════════════════════════════════════════════════════"
#	It may be intentional [or not] to have these fail.
#	Espechally when the network is configured to ban other DNS servers except the internal one for security reasons.
	echo	"	"

	echo	"pinging internal IPv4's"
	echo	"─────────────────────────────────────────────────────────────────────────"
	ping 192.168.0.1 -c 1 -D
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	ping 192.168.1.1 -c 1 -D
		echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	ping 172.16.0.1 -c 1 -D
		echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	ping 10.0.0.1 -c 1 -D
#	RFC 1918 Adress spaces
#	See:	https://en.wikipedia.org/wiki/Private_network
	echo	"─────────────────────────────────────────────────────────────────────────"
	ping 100.64.0.1 -c 1 -D
#	CGNAT
#	Failing this test is normal and should not yield any result, even if your provider uses CGNAT
#	See:	https://en.wikipedia.org/wiki/Carrier-grade_NAT
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"

	echo	"testing public hostnames"
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	nslookup google.de
	ping google.de -c 1 -D
#	Google.de
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	nslookup bsi.bund.de
	ping bsi.bund.de -c 1 -D
#	BSI
	echo	"═════════════════════════════════════════════════════════════════════════"
	echo	"	"

	echo	"DNS lookup of timeservers"
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	nslookup ptbtime1.ptb.de
	ping ptbtime1.ptb.de -c 1 -D
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	nslookup ptbtime2.ptb.de
	ping ptbtime2.ptb.de -c 1 -D
	echo	"	"
	echo	"─────────────────────────────────────────────────────────────────────────"
	echo	"	"
	nslookup ptbtime3.ptb.de
	ping ptbtime3.ptb.de -c 1 -D
#	PTB	Timeservers
#	See:	https://www.ptb.de/cms/en/ptb/fachabteilungen/abtq/gruppe-q4/ref-q42/time-synchronization-of-computers-using-the-network-time-protocol-ntp.html
	echo	"═════════════════════════════════════════════════════════════════════════"




	echo	"testing completed!"
	echo	"	"
	date
#	record date & time of end
	echo	"═════════════════════════════════════════════════════════════════════════"

} 2>&1 | tee $HOME/net-analysis.log
#	exiting the log

echo 	"	"
echo	"logfile created!"
echo	"	"

clear
#	clearing screen

echo	"	" 
echo	"╔═══════════════════════════════════════════════════════════════════════╗"
echo	"║ Tests competed!                                                       ║"
echo	"╟───────────────────────────────────────────────────────────────────────╢"
echo	"║ Please send the now opening email and an admin will contact you ASAP! ║"
echo	"╚═══════════════════════════════════════════════════════════════════════╝"
echo	"	"
#	final screen

thunderbird -compose "attachment='$HOME/net-analysis.log',to=administrator@localhost,subject=network-diagnostic-test,format=2,body=this is an automated network test"
#	hardcoded email adress & message s well as attachments.
#	ADAPT BEFORE USING!
#	since thunderbird is being used per default, this should work out of the gate, only requiring a user to press "send".
#	see: http://kb.mozillazine.org/Command_line_arguments_%28Thunderbird%29 & https://stackoverflow.com/questions/27836576/adding-several-attachments-to-thunderbird-from-command-line/28002815#28002815

exit
#	closes the script
