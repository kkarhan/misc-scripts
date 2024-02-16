#	Bash Aliases

###	---

##	Minor shortcuts to improve speed
alias cls='clear'
alias dir='ls -ahl'
###	faster to type, DOS-alike commands
alias ding='echo -ne '\007''
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
##	Random 8 digit One Time Password
alias rotp='< /dev/urandom tr -dc _A-Z-a-z-0-9 | head -c${1:-8};echo;'
##	Random 8 digit TAN
alias rtan='< /dev/urandom tr -dc 0-9 | head -c${1:-8};echo;'
##	Random 4 digit PIN
alias rpin='< /dev/urandom tr -dc 0-9 | head -c${1:-4};echo;'
###	see:	https://www.howtogeek.com/howto/30184/10-ways-to-generate-a-random-password-from-the-command-line/

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
function verify() { cat $1 | enc sig verify --key $2 --signature $1.sig ; }
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

###	---

##	Distro-Specific Parts
###	Ubuntu
alias ubdate='sudo apt-get update'
alias ubgrade='sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get autoclean && sudo snap refresh'
###	Update the System and Packages on Ubuntu - based distros

###	---
