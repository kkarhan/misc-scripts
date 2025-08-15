#	Bash Aliases


###	---


##	Minor shortcuts to improve speed
alias cls='clear'
alias dir='ls -ahl'
###	faster to type, DOS-alike commands
function ding() { echo -ne '\007'; }
###	Create a Beep [will only make a system beep if output is redirected to a local or unused console]
alias unixtime='date +%s'
###	Output Unixtime


###	---


##	Useful commands
alias flushcache='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"'
###	Flush the RAM forcefully
###	See:	https://www.cyberithub.com/drop-flush-clear-cache-memory-ram-in-linux/


### ---


##	Random Password Generator Functions
###	random UUID
alias uuid='cat /proc/sys/kernel/random/uuid'
###	128 digits
alias pw128='</dev/urandom tr -dc '0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz@!?~+#-_' | head -c128; echo;'
###	126 digits
alias pw126='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-126};echo;'
###	64 digits
alias pw64='</dev/urandom tr -dc '0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz@!?~+#-_' | head -c64; echo;'
###	62 digits
alias pw62='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-62};echo;'
###	32 digits
alias pw32='</dev/urandom tr -dc '0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz@!?~+#-_' | head -c32; echo;'
###	30 digits
alias pw30='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-30};echo;'
###	16 digits
alias pw16='</dev/urandom tr -dc '0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz@!?~+#-_' | head -c16; echo;'
###	14 digits
alias pw14='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-14};echo;'
###	Random 8 digit One Time Password
alias rotp='< /dev/urandom tr -dc A-Z-a-z-0-9 | head -c${1:-8};echo;'
###	Random 8 digit TAN
alias rtan='< /dev/urandom tr -dc 0-9 | head -c${1:-8};echo;'
###	Random 4 digit PIN
alias rpin='< /dev/urandom tr -dc 0-9 | head -c${1:-4};echo;'
###	see:	https://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/

###	Alternative Method
###	See:	https://osxdaily.com/2011/05/10/generate-random-passwords-command-line/ for details
alias pw127='openssl rand -base64 127 | head -c 127; echo'
alias pw63='openssl rand -base64 63 | head -c 63; echo'
alias pw31='openssl rand -base64 31 | head -c 31; echo'
alias pw15='openssl rand -base64 15 | head -c 15; echo'
alias pw7='openssl rand -base64 7 | head -c 7; echo'

###	More flexible option
function shex() { openssl rand -hex "$1" | head -c "$1"; echo; }
function rpaw() { < /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c "$1"; echo; }
function rpas() { < /dev/urandom tr -dc '0123456789AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz@!?~+#-_' | head -c "$1"; echo; }
function rnum() { < /dev/urandom tr -dc 0-9 | head -c "$1"; echo; }
function spas() { openssl rand -base64 "$1" | head -c "$1"; echo; }

###	Bad Speudorandom Generators
alias pr128='unixtime | sha512sum | head -c 128; echo;'
alias pr64='unixtime | sha256sum | head -c 64; echo;'
alias pr40='unixtime | sha1sum | head -c 40; echo;'
alias pr32='unixtime | md5sum | head -c 32; echo;'
####	Using unixtime instead of date for transparency.

###	---


##	Checksumming
function md5() { md5sum "$1" | head -c 32; echo; }
###	MD-5 Checksum
function sha1() { sha1sum "$1" | head -c 40; echo; }
###	SHA-1 Checksum
function sha256() { sha256sum "$1" | head -c 64; echo; }
###	SHA-256 Checksum
function sha512() { sha512sum "$1" | head -c 128; echo; }
###	SHA-512 Checksum


###	---


##	Cryptographic Functions and Routines often used
alias enc='$HOME/.apps/enc/enc'
###	Addning enc to the toolchain
###	See:	https://github.com/life4/enc	for details
###	See:	https://github.com/life4/enc/releases/latest	for Downloads
function encrypt() { cat "$1" | enc encrypt --key "$2" | enc armor > "$1.encrypted.asc" ; }
###	Encrypts file $1 with PGP pubkey in file $2 and saves it as ASCII-armoured message in file $1.encrypted.pgp
###	See:	https://github.com/life4/enc#encryptdecrypt-with-a-key
function decrypt() { cat "$1" | enc dearmor | enc decrypt --key "$2" > $1.decrypted ; }
###	Decrypts file $1 with PGP privkey in file $2 and saves it as plaintext message in file $1.decrypted
###	See:	https://github.com/life4/enc#use-public-key-generate-and-encrypt
function sign() { cat $1 | enc sig create --key $2 | enc sig armor > $1.sig ; }
###	Signs file $1 with key $2 and saves the signature as $1.sig
###	See:	https://github.com/life4/enc#sign
function verify() { cat $1 | enc sig verify --key $2 -- signature $1.sig ; }
###	Verifies file $1 against key $2 and signature $1.sig
###	See:	https://github.com/life4/enc#verify-signature
function keygen() { enc key generate -b 8192 -c "$1" -e "$2" -n "$3" --ttl "128y" | enc armor > $2.seckey.asc && echo '$2.seckey.asc generated!' && cat $2.seckey.asc | enc dearmor | enc key public | enc armor > $2.pubkey.asc && echo 'pubkey is $2.pubkey.asc' ; }
###	Generates public-private keypair with comment $1, email $2 name $3 and shoves that into $2.seckey.asc
###	See:	https://github.com/life4/enc#generate-a-key
### And also extracts public key and shoves it into a seperate file: $2.pubkey.asc
###	See:	https://github.com/life4/enc#use-public-key-generate-and-encrypt
function mount-luks() { sudo cryptsetup luksOpen /dev/$1 $2 && sudo mount /dev/mapper/$2 /media/$USER/$2 && echo '/dev/$1 has been mounted on /media/$USER/$2' ; }
###	Mount & unlock LUKS partition named $2 located on /dev/$1 to /media/$USER/$2
###	This is vital for encrypted drives on servers that won't e automounted for security reasons!


###	---


##	Upload files and send notifications
function upload() { curl -T $1 https://oshi.at ; }
###	Uploads file $1 to oshi.at
###	See:	https://oshi.at/cmd
function notify() { curl -d "$1" ntfy.sh/$2 ; }
###	Sends message ""$1" to ntfy.sh/$2
###	See:	https://docs.ntfy.sh/publish


###	---


##	Download Videos and Audio
function mp3dl() { yt-dlp -x --audio-format mp3 "$@"; }
###	download a video's audio as mp3
###	requires yt-dlp & ffmpeg to be installed
function vdl() { yt-dlp "$@"; }
###	download a video
###	requires yt-dlp to be installed


###	---


#	Update the .bash_aliases file
alias aliasupdate='./aliasupdate.sh'
###	update aliases

###	---

#   Connectivity Diagnostics
function isup() { ping -a -b -c 1 -D "$@"; }
###	Single Ping attempt to a specific host which has to be specified i.e. "isup duckduckgo.com"
###	This is done to see if a host "is up"...
alias pubip='curl https://wtfismyip.com/text ; echo;'
###	find public IP adress
###	NOTE:	Lack of connectivity will result in a 404 error!
###	alternative Service:	ipinfo.io/ip
###	see:	https://stackoverflow.com/questions/14594151/methods-to-detect-public-ip-address-in-bash/14594304#14594304
alias pub4='curl http://ip4only.me/api/ ; echo;'
###	find public IPv4 adress
###	see:	http://ip4only.me/
###	NOTE:	Lack of IPv4 connectivity will result in a 404 error!
alias pub5='curl http://api64.ipify.org ; echo;'
###	find public IPv4 or IPv6 based off OS & Network preference
###	see:	https://www.ipify.org/
###	NOTE:	Lack of connectivity will result in a 404 error!
alias pub6='curl https://ip6only.me/api/ ; echo;'
###	find public IPv6 adress
###	see:	https://ip6only.me/
###	NOTE:	Lack of IPv6 connectivity will result in a 404 error!
function udpup() { sudo nmap -sU -p $@; }
###	Check if service on host & port reachable via UDP
###	it needs to be written port host [i.e. 80 host.domain.example]
function tcpup() { sudo nmap -sT -p $@; }
###	Check if service on host & port is reachable via TCP
###	it needs to be written port host [i.e. 9001 host.domain.example]

###	---


##	Distro-Specific Parts
###	Ubuntu
alias ubdate='sudo apt-get update'
alias ubgrade='sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get autoclean && sudo snap refresh'
###	Update the System and Packages on Ubuntu - based distros


###	---


##	VirusTotal API functions
####	These are subject to the terms of Service for VirusTotal and subsequent account limits.
#####	Please see: https://docs.virustotal.com/reference/getting-started for details
###	All functions have been built for & tested with VirusTotal API v3.

###	VirusTotal API Key
VT_APIKEY="no valid VirusTotal API Key specified!"
####	You need to enter your VirusTotal API key for authentification with VirusTotal.
#####   Please see: https://docs.virustotal.com/reference/public-vs-premium-api for terms and conditions.
####	You get a free API key by signing up for a community account.
#####	Note that for commercial use and/or more than 500 requests per day and/or more than 4 requests per minute, you need a Premium Account.
#####	You can find the API Key in your VirusTotal account.
######	See: https://docs.virustotal.com/reference/authentication for details.
###	Show VirusTotal API Key
alias show_vtapikey='echo "$VT_APIKEY"'
#####	this function will spit out your VirusTotal API Key. If you have none setup, it'll say "no valid VirusTotal API Key specified!"
######	If your API key is expired/invalidated/... the API of VirusTotal will tell you with a 401 error.
######	You can out-comment show_vtapikey. It was merely added to help in development.
alias VT_ID='sha256sum $1 | head -c 64; echo ;'
###	Get a SHA-256 checksum.
####	This is used in several functions down the line.

###	Scanning Files
####	See:	https://docs.virustotal.com/reference/files-scan for details
function vtscanfile() { curl --request POST --url https://www.virustotal.com/api/v3/files --header 'accept: application/json' --header 'content-type: multipart/form-data' --header 'x-apikey: $VT_APIKEY' "$1" ; }
###	Scan a regular file: vtscanfile $FILE
####	Note: File Size is limited to 32MB
function vtscanzip() { curl --request POST --url https://www.virustotal.com/api/v3/files --header 'accept: application/json' --header 'content-type: multipart/form-data' --header 'x-apikey: $VT_APIKEY'--form 'password=$2' "$1" ; }
###	Scan an encrypted ZIP file: vtscanzip $FILE $PASSWORD
####	NOTE: File Size is limited to 32MB
function vtuploadurl() { curl --request GET --url https://www.virustotal.com/api/v3/files/upload_url --header 'accept: application/text' --header 'x-apikey: $VT_APIKEY'; "$1"; }
###	Request an upload URL for uploading a file >32MB size, to a maximum of 650MB size.
####	This is generally disrecommended for various reasons.
####	See:	https://docs.virustotal.com/reference/files-upload-url for details.
function vtscanurl() { $1 > $url; curl --request POST --url https://www.virustotal.com/api/v3/urls --header 'accept: application/json' --header 'content-type: application/x-www-form-urlencoded' \ --header 'x-apikey: $VT_APIKEY' \ --data 'url=$url' ; }
###	Request an URL scan
####	See:	https://docs.virustotal.com/reference/scan-url for details.
function vtscandomain() { $1 > $domain; curl --request GET --url https://www.virustotal.com/api/v3/domains/$domain --header 'accept: application/json' --header 'x-apikey: $VT_APIKEY'; }
###	Request a Domain Report
####	See:	https://docs.virustotal.com/reference/domain-info for details.
function vtscanip() { $1 > $ip; curl --request GET --url https://www.virustotal.com/api/v3/ip_addresses/$ip --header 'accept: application/json' --header 'x-apikey: $APIKEY'; }
###	Request a IP Report
####	See:	https://docs.virustotal.com/reference/ip-info for details.
function vtanalyze() { VT_ID $1 > $id; curl --request GET --url https://www.virustotal.com/api/v3/analyses/$id --header 'accept: application/json' --header 'x-apikey: $VT_APIKEY'; }
###	Request a file analysis
####	This may also include previous analysis done before.
####	See:	https://docs.virustotal.com/reference/analysis for details.
function vtrescan() { VT_ID $1 > $id; curl --request POST --url https://www.virustotal.com/api/v3/files/$id/analyse --header 'accept: application/json' --header 'x-apikey: $VT_APIKEY'; }
###	Request a rescan of a file that has been scanned.
####	Caution: This is disrecommend.
####	See:	https://docs.virustotal.com/reference/files-analyse for details.
function vtreport() { VT_ID $1 > $id; curl --request GET --url https://www.virustotal.com/api/v3/files/$id --header 'accept: application/json' --header 'x-apikey: $VT_APIKEY'; }
###	Get a file Report based off it'checksum.
####	This will take any report available.
####	See:	https://docs.virustotal.com/reference/file-info	for details.