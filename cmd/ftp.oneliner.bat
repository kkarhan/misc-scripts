##	As well as:	https://www.windowsdigitals.com/download-ftp-file-using-cmd-in-windows-11-10/
echo open ftp.example >> ftp &echo user USERNAME PASSWORD >> ftp &echo binary >> ftp &echo get example.file >> ftp &echo bye >> ftp &ftp -n -v -s:ftp &del ftp >> exit
#   TODO: Customize URLs