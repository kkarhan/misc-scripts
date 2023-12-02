@echo off
#	BITSadmin download example
##	Source:	https://superuser.com/questions/59465/is-it-possible-to-download-using-the-windows-command-line/284147#284147
bitsadmin /transfer mydownloadjob /download /priority normal http://example.com/filename.zip C:\Users\username\Downloads\filename.zip
#   TODO: Customize URLs
echo done!
exit
