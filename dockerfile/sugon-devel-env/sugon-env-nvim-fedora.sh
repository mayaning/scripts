#!/bin/bash
# #######################################################
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
# #######################################################
#
##
# @file sugon-devel-env.sh
# @Brief
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2022-01-07
#
set -o errexit

function install_depends_packages()
{
    container=$1
    cfg=$2

    #Upgrade system
    buildah run $container dnf -y upgrade
    
    # 安装软件
    buildah run $container dnf -y install neovim python3-neovim clang-libs \
        clang-devel boost boost-devel cmake python3-devel golang pwgen  \
        cscope ctags nodejs yarnpkg rust fzf bat the_silver_searcher    \
        ripgrep perl

    # 清除dnf缓存
    buildah run $container dnf clean all
}

function setup_fzf()
{
    local container=$1

    rm -rf fzf
    tar xzvf fzf.tar.gz
    buildah copy $container fzf/dot.fzf /root/.fzf
    buildah copy $container fzf/dot.fzf.bash /root/.fzf.bash
    #buildah run $container echo "[ -f ~/.fzf.bash ] && source ~/.fzf.bash" >> /root/.bashrc
    rm -rf fzf
}

function setup_nvim()
{
    local container=$1 

    rm -rf nvim 
    tar xzvf nvim.tar.gz

    buildah run $container mkdir -p /root/.config/nvim
    buildah run $container mkdir -p /root/.local/share/nvim/plugged
    buildah copy $container nvim/nvim /root/.config/nvim
    buildah copy $container nvim/plugged /root/.local/share/nvim/plugged

    rm -rf nvim 
}

function install_pyton_depends()
{
    local container=$1 

    buildah copy $container py-depends.txt /tmp
    buildah run $container pip install -r /tmp/py-depends.txt
    buildah run $container  rm -rf /tmp/py-depends.txt
}


# #######################################################
# 从这里开始
# #######################################################
step=0

echo "Create sugon env from fedora:36"

# Create a container
CONTAINER=$(buildah from fedora:36)

# Labels are part of the "buildah config" command
buildah config --label maintainer="mayaning<mayaning4coding@163.com>" $CONTAINER

let step+=1
echo "Step $step: Setup endpoint"
# Entrypoint, too, is a “buildah config” command
buildah copy $CONTAINER endpoint.sh /usr/bin
buildah run $CONTAINER chmod a+x /usr/bin/endpoint.sh
buildah config --cmd /usr/bin/endpoint.sh $CONTAINER
buildah config --env LANG=C.UTF-8 $CONTAINER
buildah config --volume /workspace $CONTAINER
buildah config --workingdir /workspace $CONTAINER

# 安装依赖软件包
let step+=1
echo "Step $step: Install depend packages"
install_depends_packages $CONTAINER

# 安装python包
#let step+=1
#echo "Step $step: Install python depend packages"
#install_pyton_depends $CONTAINER

# 设置VIM, 注释掉，以减小Image大小
let step+=1
echo "Step $step: Setup fzf"
setup_fzf $CONTAINER

# 设置VIM, 注释掉，以减小Image大小
let step+=1
echo "Step $step: Setup vim"
setup_nvim $CONTAINER

# Finally saves the running container to an image
let step+=1
echo "Step $step: Commit container image"
buildah commit --format docker $CONTAINER sugon-env-nvim-fedora:latest

# 导出容器镜像
let step+=1
echo "Step $step: Export container image"
rm -rf sugon-env-nvim-fedora.tar.gz
podman save --format docker-archive -o sugon-env-nvim-fedora.tar.gz \
    sugon-env-nvim-fedora:latest
