#!/bin/bash

function install_depends_packages()
{
	#Enable rpmfusion repo
    yum -y localinstall --nogpgcheck \
    https://download1.rpmfusion.org/free/el/rpmfusion-free-release-7.noarch.rpm \
    https://download1.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-7.noarch.rpm

	#Upgrade system
	yum -y upgrade

	#Install depends packages
	yum -y install jq

	echo "***** Install depends packages *****"
	#Install depends groups
	length=`cat $1 | jq '.rpm_depends_groups | length'`
	for (( i=0; i<$length; i+=1 )); do
		group=`cat $1 | jq ".rpm_depends_groups[$i]"`
		group=`echo $group | sed "s/\"//g"`
		yum -y groupinstall "$group"
	done

	#Install depends packages
	rpm_depends=`cat $1 | jq ".rpm_depends" | sed "s/\[//g" | sed "s/\]//g" | \
		sed "s/,//g" | sed "s/\"//g" | sed "/^$/d" | tr -d "\n" |  \
		sed "s/^ *//g"`
	yum -y install $rpm_depends
}

function usage()
{
    echo "$1 <cfg_file>"
}

#Start from here
if [ $# != 1 ]; then
    usage $0
    exit -1
fi
cfg_file=$1
install_depends_packages $cfg_file
