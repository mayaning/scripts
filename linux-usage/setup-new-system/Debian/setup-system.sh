#!/bin/bash

function upgrade_system()
{
    echo "***** Upgrade system *****"
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

function install_vim_with_python_support()
{
    # From:
    # https://github.com/Valloric/YouCompleteMe/wiki/Building-Vim-from-source.
    git clone https://github.com/vim/vim.git
    pushd vim
    make distclean
    ./configure --with-features=huge \ --enable-multibyte \
        --enable-rubyinterp=yes \
        --enable-pythoninterp=yes \
        --with-python-config-dir=/usr/lib/python2.7/config-x86_64-linux-gnu \
        --enable-python3interp=yes \
        --with-python3-config-dir=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu \
        --enable-perlinterp=yes \
        --enable-luainterp=yes \
        --enable-gui=gtk2 --enable-cscope --prefix=/usr

    make VIMRUNTIMEDIR=/usr/share/vim/vim81 && make install

    update-alternatives --install /usr/bin/editor editor /usr/bin/vim 1
    update-alternatives --set editor /usr/bin/vim
    update-alternatives --install /usr/bin/vi vi /usr/bin/vim 1
    update-alternatives --set vi /usr/bin/vim
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
add_static_domain
