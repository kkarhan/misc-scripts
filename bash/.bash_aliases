#	Bash Aliases

##	Random Password Generator Functions
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

##	Useful commands
alias flushcache='sudo sh -c "sync; echo 3 > /proc/sys/vm/drop_caches"'
###	Flush the RAM forcefully
###		See:	https://www.cyberithub.com/drop-flush-clear-cache-memory-ram-in-linux/

alias ubdate='sudo apt-get update'
alias ubgrade='sudo apt-get dist-upgrade && sudo apt-get autoremove && sudo apt-get autoclean && sudo snap refresh'
###	Update the System and Packages on Ubuntu - based distros

alias cls='clear'
alias dir='ls -ahl'
###	faster to type, DOS-alike commands

alias ding='echo -ne '\007''

function isup() { ping -a -b -c 1 -D "$@"; }
###	Single Ping attempt to a specific host which has to be specified i.e. "isup duckduckgo.com"

function mp3dl() { yt-dlp -x --audio-format mp3 "$@"; }
###	download a video's audio as mp3
### requires yt-dlp & ffmpeg to be installed

function vdl() { yt-dlp "$@"; }
### download a video
### requires yt-dlp to be installed

alias aliasupdate='./aliasupdate'
### update aliases

alias pubip='curl ipinfo.io/ip ; echo;'
### find public IP adress
### see:    https://stackoverflow.com/questions/14594151/methods-to-detect-public-ip-address-in-bash/14594304#14594304
### NOTE:   Lack of connectivity will result in a 404 error!

alias pub4='curl http://ip4only.me/api/ ; echo;'
### find public IPv4 adress
### see:    http://ip4only.me/
### NOTE:   Lack of IPv4 connectivity will result in a 404 error!

alias pub6='curl https://ip6only.me/api/ ; echo;'
### find public IPv6 adress
### see:    https://ip6only.me/
### NOTE:   Lack of IPv6 connectivity will result in a 404 error!

alias pub5='curl http://whatismyv6.com/api/ ; echo;'
### find public IPv4 or IPv6 based off OS & Network preference
### see:    http://whatismyv6.com/
### NOTE:   Lack of connectivity will result in a 404 error!