@echo off
#	certutil download example
##	Source:	https://superuser.com/questions/25538/how-to-download-files-from-command-line-in-windows-like-wget-or-curl/373068#373068
certutil.exe -urlcache -split -f "https://download.sysinternals.com/files/PSTools.zip" pstools.zip
#   TODO: Customize URLs
echo done!
exit
