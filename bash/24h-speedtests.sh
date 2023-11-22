 #!/bin/bash
script -a ./speedtests.log -q
echo "24h speedtest data collection!"
echo "Starting now..."
for (( i=1; i<=100; i++ ))
#   100 tests starting with 1 ending with 100
	do 
		echo "Network Test" $i
		#   Number of Test in loop
		date +%s
		#   Unixtime
		date
		#   local time
		curl ipinfo.io/ip; echo;
		#   query public IP adress
		speedtest -s 32412 -I enp2s0 -p no -a -P 8 -v
		#   selecting speedtest server #32412, binding the ethernet interface, not showing progress bars, automatic decimal bits, highest precision [8 digits] and verbose output
		echo "Network Test " $i " done!"
		echo; echo;
		#   adding two seperate lines
		sleep 900
		#   this will set the wait 15 min = 900s between tests.
		#	as 15*24 = 96, this test will have some sufficient overlap and will provide 24hrs of test data.
done
echo "Tests are done and logged into ./speedtests.log"
echo "done!"
exit
exit
