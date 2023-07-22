#!/usr/bin/env bash

#	Keeping it portable.
#	see:	https://www.cyberciti.biz/tips/finding-bash-perl-python-portably-using-env.html

cd $HOME
echo "backing up old bash_aliases..."
mv ./.bash_aliases ./.bash_aliases.old
mv ./.aliasupdate.sh ./.aliasupdate.sh.old
echo "downloading new version..."
wget https://raw.githubusercontent.com/kkarhan/misc-scripts/master/bash/.bash_aliases
wget https://raw.githubusercontent.com/kkarhan/misc-scripts/master/bash/.aliasupdate.sh
chmod +x ./aliasupdate.sh
echo "done - closing terminal session..."
## Download the latest version of .bash_aliases from my GitHub
### See: https://github.com/kkarhan/misc-scripts/blob/master/bash/.bash_aliases

exit
