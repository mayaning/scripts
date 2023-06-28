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
# @file setup_system_env.sh
# @Brief 系统级环境配置
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2022-12-10

set -xe

#********************************************************/
#
# @Brief install_depends_packages 
#   安装系统依赖软件
#
# @Returns
#
#********************************************************/
function install_depends_packages()
{
    # 更新系统
    dnf -y upgrade

    dnf -y group install "C Development Tools and Libraries"
    
    # 安装软件
    dnf -y install neovim python3-neovim clang-libs clang-devel boost \
        boost-devel cmake python3-devel golang pwgen  cscope ctags nodejs \
        yarnpkg rust bat the_silver_searcher ripgrep perl lcov
}


# #######################################################
# 从这里开始
# #######################################################
install_depends_packages
