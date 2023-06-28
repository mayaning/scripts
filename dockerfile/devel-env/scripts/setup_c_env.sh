#!/bin/bash
# *******************************************************
# Copyright 2021 - 2022 Ma Yaning
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
# *******************************************************
# @file setup_c_env.sh
# @Brief
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2022-12-10

set -xe

# ********************************************************/
# @Brief install_cunit 
#   安装C语言单元测试工具CUnit
#
# @Returns
# ********************************************************/
function install_cunit()
{
    dnf install -y CUnit CUnit-devel   
}


# ********************************************************/
# @Brief install_zlog 
#   安装C语言Log库zlog
#
# @Returns
# ********************************************************/
function install_zlog()
{
    local workdir=$1

    # 获取zlog源码
    # git clone https://github.com/HardySimpson/zlog.git
    # gh repo clone HardySimpson/zlog
    pushd $workdir/packages > /dev/null 2>&1
    tar xzvf zlog-1.2.16.tar.gz

    # 编译安装zlog
    pushd zlog-1.2.16 > /dev/null 2>&1
    make PREFIX=/usr
    make PREFIX=/usr install
    popd > /dev/null 2>&1

    # 复制zlog配置文件
    mkdir -p /etc/zlog
    cp $workdir/configs/zlog.config /etc/zlog/

    popd > /dev/null 2>&1
}


# #######################################################
# 从这里开始
# #######################################################
TMP_WORKDIR=$1

install_cunit
install_zlog $TMP_WORKDIR
