#!/bin/bash

function install_depends_packages()
{
	#Enable rpmfusion repo
	dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
		https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

	#Upgrade system
	dnf -y upgrade

	#Install depends packages
	dnf -y install jq


	echo "***** Install depends packages *****"
	#Install depends groups
	length=`cat $1 | jq '.rpm_depends_groups | length'`
	for (( i=0; i<$length; i+=1 )); do
		group=`cat $1 | jq ".rpm_depends_groups[$i]"`
		group=`echo $group | sed "s/\"//g"`
		dnf -y groupinstall "$group"
	done

	#Install depends packages
	rpm_depends=`cat $1 | jq ".rpm_depends" | sed "s/\[//g" | sed "s/\]//g" | \
		sed "s/,//g" | sed "s/\"//g" | sed "/^$/d" | tr -d "\n" |  \
		sed "s/^ *//g"`
	dnf -y install $rpm_depends
}

function setup_fcitx()
{

    echo '#!/bin/bash' > /etc/profile.d/fcitx.sh
    echo 'export GTK_IM_MODULE=fcitx' >> /etc/profile.d/fcitx.sh

    echo 'export QT_IM_MODULE=fcitx' >> /etc/profile.d/fcitx.sh
    echo 'export XMODIFIERS="@im=fcitx"' >> /etc/profile.d/fcitx.sh

    chmod a+x /etc/profile.d/fcitx.sh
}

function add_static_domain()
{
    #从配置文件中取得static_domaians(包括域名和地址对)信息
    static_domains=`cat $1 | jq ".static_domains"`
    #获取域名和地址对的个数
	length=`echo $static_domains | jq '. | length'`
    #获取所有的域名列表
    domains=`echo $static_domains | jq '. | keys'`

    #获取每个域名地址对，写入/etc/hosts文件
	for (( i=0; i<$length; i+=1 )); do
        key=`echo $domains | jq ".[$i]"`
        val=`echo $static_domains | jq ".$key"`
        domain=`echo $key | sed "s/\"//g"`
        ip=`echo $val | sed "s/\"//g"`
        
        #查看/etc/hosts中是否有相同的配置，如果有则覆盖掉
        str=`grep $domain /etc/hosts`
        if [ "x$str" != "x" ]; then
            for s in $str
            do
                sed -i "/$s/d" /etc/hosts
            done
        fi

        #将配置写入
        echo $ip $domain >> /etc/hosts
    done
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
add_static_domain $cfg_file
#gsettings set org.gnome.mutter experimental-features "['scale-monitor-framebuffer']"
