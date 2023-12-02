@echo off
#	ftp downlaod example
##	Source:	https://itstillworks.com/12263054/how-to-test-the-internet-connection-of-ubuntu-server
##	As well as:	https://tecadmin.net/download-upload-files-using-ftp-command-line/

ftp
open ftp.domain.example
username
password
get example.file
bye

#   TODO: Customize URLs
echo done!
exit