#!/bin/bash

function upgrade_system()
{
    echo "***** Upgrade system *****"
    apt -y update
    apt -y upgrade

    #Install depends packages
    apt -y install jq
}

function install_depends_packages()
{
    echo "***** Install depends packages *****"

    #Install depends packages
    packages=`cat $CFG_FILE| jq ".packages" | sed "s/\[//g" | sed "s/\]//g" | \
        sed "s/,//g" | sed "s/\"//g" | sed "/^$/d" | tr -d "\n" |  \
        sed "s/^ *//g"`
    apt -y install $packages
}

function add_static_domain()
{

    echo "***** Configure static domains *****"
    #从配置文件中取得static_domaians(包括域名和地址对)信息
    static_domains=`cat $CFG_FILE | jq ".static_domains"`
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

upgrade_system

CFG_FILE=$1
install_depends_packages
#add_static_domain
