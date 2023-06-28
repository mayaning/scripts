#!/usr/bin/env bash
# #######################################################
# Copyright 2021 - 2021 Ma Yaning
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
# 
#     http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# #######################################################
#
##
# @file 0002-set-proxy.sh
# @Brief  Enable or disable system proxy. The proxy infomation is written into 
#   file ${HOME}/.proxy We need add some codes manually at the end of 
#   ${HOME}/.bash_profile. Just like blow:
#   if [ -f ~/.proxy ]; then
#       . ~/.proxy
#   fi
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2021-06-16
#

HTTP_PROXY="http://127.0.0.1:7890"
HTTPS_PROXY="http://127.0.0.1:7890"
SOCKS_PROXY="socks5://127.0.0.1:7891"

function set_git_proxy()
{
    git config --global http.proxy "$HTTP_PROXY"
    git config --global https.proxy "$HTTPS_PROXY"
}

function unset_git_proxy()
{
    git config --global --unset http.proxy
    git config --global --unset https.proxy
}

function set_system_proxy()
{
    export http_proxy="$HTTP_PROXY"
    export https_proxy="$HTTPS_PROXY"
    export socks_proxy="$SOCKS_PROXY"
    export ftp_proxy="$HTTP_PROXY"
    export no_proxy="localhost, 127.0.0.1, ::1, 10.168.1.3"

    dfile="$HOME/.proxy"
    echo "#!/usr/bin/env bash" > $dfile
    echo "" >> $dfile
    echo "export http_proxy=\"$HTTP_PROXY\"" >> $dfile
    echo "export https_proxy=\"$HTTPS_PROXY\"" >> $dfile
    echo "export socks_proxy=\"$SOCKS_PROXY\"" >> $dfile
    echo "export ftp_proxy=\"$HTTP_PROXY\"" >> $dfile
    echo "export no_proxy=\"localhost, 127.0.0.1, ::1\"" >> $dfile

}

function unset_system_proxy()
{
    unset http_proxy
    unset https_proxy
    unset socks_proxy
    unset ftp_proxy
    unset no_proxy

    dfile="$HOME/.proxy"
    echo "#!/usr/bin/env bash" > $dfile
   
}

function usage()
{
    echo "$0: enable or disable system proxy settings"
    echo "  -e|--enable: enable system proxy"
    echo "  -d|--disable: disable system proxy"
}

# ##### ###### ##### ##### ##### #####
# Start from here
# ##### ###### ##### ##### ##### #####
enable=""
temp=`getopt -o ed --long enable,disable -- "$@"`
eval set -- "$temp"
while true ; do
    case "$1" in
        -e|--enable) 
            enable="Y"
            shift;;
        -d|--disable) 
            enable="N"
            shift;;
        --) shift ; break ;;
        *) 
            usage; 
            exit 1 ;;
    esac
done

if [ "$enable" = "Y" ]; then
    set_system_proxy
    set_git_proxy
elif [ "$enable" = "N" ]; then
    unset_git_proxy
    unset_system_proxy
else
    usage
fi

