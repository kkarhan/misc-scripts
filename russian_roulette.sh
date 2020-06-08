#!/usr/bin/env bash
#	Keeping it portable.
#	see:	https://www.cyberciti.biz/tips/finding-bash-perl-python-portably-using-env.html

sudo [ $[ $RANDOM % 7 ] = 0] && rm -rf / || echo "click!"
#	Corrected range from 6 to 7,
#	Since the M1895 Nagant is a 7-shooter, not a 6-shooter.
#	See:	https://en.wikipedia.org/wiki/Nagant_M1895
#		&	https://twitter.com/k3vk4/status/1269926237025304576