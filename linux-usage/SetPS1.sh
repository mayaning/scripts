#!/bin/bash
#  Place this script within /etc/profile.d
#  chmod 755  
BRed='\[\033[1;31m\]'
BYel='\[\033[1;33m\]'
#BWhi='\[\033[1;37m\]'
#Whit='\[\033[0;37m\]'

if [ $EUID = 0 ];
then
    PS1="[${BRed}\u\[\033[1;37m\]@\[\033[1;36m\]\h \[\033[1;36m\]\W\[\033[1;37m\]]\[\033[0;37m\]\$" 
else
    PS1="[${BYel}\u\[\033[1;37m\]@\[\033[1;36m\]\h \[\033[1;32m\]\W\[\033[1;37m\]]\[\033[0;37m\]\$" 
fi
