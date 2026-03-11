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

BASE_IMAGE_NAME="sugon-env-base-ubuntu24.04"
BASE_IMAGE_TAG="latest"
SUGON_ENV_IMAGE_NAME="sugon-env-ubuntu24.04"
SUGON_ENV_IMAGE_TAG="latest"

kernel_version=6.8.0-31
ctags_version=6.2.0
clangd_version=21.1.8
nodejs_version=v24.13.0
golang_version=1.25.6
tmux_version=3.6a

function install_depends_packages()
{
    local container=$1

    # 替换为国内源
    buildah run $container sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' \
        /etc/apt/sources.list.d/ubuntu.sources

    # Upgrade system
    buildah run $container apt -y update
    buildah run $container apt -y upgrade

    # Install depends packages
    buildah run $container apt -y install build-essential wget curl cmake \
        git zsh universal-ctags cscope tree openssh-server automake \
        pkg-config ripgrep trash-cli clang fzf gdbserver lldb llvm \
        libncurses-dev gawk flex bison openssl libssl-dev dkms libelf-dev \
        libudev-dev libpci-dev libiberty-dev autoconf libncurses-dev \
        gcc bc dwarves fakeroot gem bear crash unzip wl-clipboard \
        libevent-dev help2man readline-common libblkid-dev lua5.4 \
        uuid-dev libaio1t64 libaio-dev yasm nasm libip4tc-dev libip6tc-dev \
        libiptc-dev libxtables-dev vim python-is-python3 gradle openssh-server \
        subversion libnuma-dev numactl zlib1g zlib1g-dev nfs-common gdb jq \
        texinfo lsb-release python3.12-venv
}

function setup_kernel()
{
    local container=$1

    buildah run $container apt -y install \
        linux-image-${kernel_version}-generic \
        linux-headers-${kernel_version}-generic \
        linux-modules-${kernel_version}-generic \
        linux-modules-extra-${kernel_version}-generic
}


function setup_ctags()
{
    local container=$1

    buildah add $container assets/universal-ctags-${ctags_version}.tar.gz /tmp/
    buildah run $container -- bash -lc "
        cd /tmp/universal-ctags-${ctags_version} &&
        ./autogen.sh &&
        ./configure --prefix=/usr/local &&
        make &&
        make install &&
        cd - &&
        rm -rf /tmp/universal-ctags-${ctags_version}
        "
}

function setup_clangd()
{

    local container=$1

    buildah add $container assets/clangd-linux-${clangd_version}.zip /opt/
    buildah config -e PATH=/opt/clangd_${clangd_version}/bin:$PATH $container
}

function setup_nodejs()
{

    local container=$1

    buildah add $container assets/node-${nodejs_version}-linux-x64.tar.xz /opt/
    buildah config -e PATH=/opt/node-${nodejs_version}-linux-x64/bin:$PATH $container
}

function setup_rust()
{
    local container=$1

    buildah run $container -- bash -lc \
        "curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y"
    buildah config -e PATH=/root/.cargo/bin:$PATH $container
}

function setup_golang()
{

    local container=$1

    buildah add $container assets/go${golang_version}.linux-amd64.tar.gz /opt/
    buildah config -e PATH=/opt/go/bin:$PATH  $container
    buildah config -e GOPATH=$HOME/.local/Golang $container
}

function setup_nvim()
{
    local container=$1

    buildah add $container assets/nvim-linux-x86_64.tar.gz /opt
    buildah config -e PATH=/opt/nvim-linux-x86_64/bin:$PATH $container
    buildah run $container git clone https://github.com/mayaning/mylazynvim.git /root/.config/nvim
    buildah run $container vim -m "Lazy install" "+q" "+q"
    buildah run $container vim -m "MasonInstall" "+q" "+q"
}

function setup_tmux()
{
    local container=$1

    buildah add $container assets/tmux-${tmux_version}.tar.gz /tmp/
    buildah run $container -- bash -lc " 
        cd /tmp/tmux-${tmux_version} &&
        ./configure --prefix=/usr &&
        make &&
        make install &&
        cd - &&
        rm /tmp/tmux* -rf
        "
}


function build_base_image()
{
    local container=$(buildah from ubuntu:24.04)
    buildah config -e DEBIAN_FRONTEND=noninteractive $container

    echo "Build base image: install depend packages"
    install_depends_packages $container

    echo "Build base image: install kernel"
    setup_kernel $container

    echo "Build base image: commit image"
    buildah commit --format docker $container ${BASE_IMAGE_NAME}:${BASE_IMAGE_TAG}
}

function download_depend_software()
{
    mkdir -p assets

    pushd assets

    wget https://github.com/universal-ctags/ctags/releases/download/v${ctags_version}/universal-ctags-${ctags_version}.tar.gz
    wget https://github.com/clangd/clangd/releases/download/${clangd_version}/clangd-linux-${clangd_version}.zip
    wget https://nodejs.org/dist/${nodejs_version}/node-${nodejs_version}-linux-x64.tar.xz
    wget https://dl.google.com/go/go${golang_version}.linux-amd64.tar.gz
    wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    wget https://github.com/tmux/tmux/releases/download/${tmux_version}/tmux-${tmux_version}.tar.gz

    popd
}

function build_sugon_dev_image()
{
    local container=$(buildah from $BASE_IMAGE_NAME:$BASE_IMAGE_TAG)

    # Labels are part of the "buildah config" command
    buildah config --label maintainer="mayaning<mayaning4coding@163.com>" $container

    # Entrypoint, too, is a “buildah config” command
    buildah copy $container endpoint.sh /usr/bin
    buildah run $container chmod a+x /usr/bin/endpoint.sh
    buildah config --cmd /usr/bin/endpoint.sh $container
    buildah config --env LANG=C.UTF-8 $container
    buildah config --volume /workspace $container
    buildah config --workingdir /workspace $container
    buildah config -e DEBIAN_FRONTEND=noninteractive $container

    setup_ctags $container
    setup_clangd $container
    setup_nodejs $container
    setup_rust $container
    setup_golang $container
    setup_nvim $container

    buildah commit --format docker $container $SUGON_ENV_IMAGE_NAME:$SUGON_ENV_IMAGE_TAG

    rm -rf sugon-env-ubuntu24.04.tar.gz
    # 导出Docker格式的镜像
    buildah push $SUGON_ENV_IMAGE_NAME:$SUGON_ENV_IMAGE_TAG \
        docker-archive:${SUGON_ENV_IMAGE_NAME}.tar.gz:${SUGON_ENV_IMAGE_NAME}:${SUGON_ENV_IMAGE_TAG}
    # 使用Docker导入镜像
    # docker load -i ${SUGON_ENV_IMAGE_NAME}.tar.gz
    # 将镜像推送到Docker服务
    sudo buildah push  $SUGON_ENV_IMAGE_NAME:$SUGON_ENV_IMAGE_TAG \
        docker-daemon:$SUGON_ENV_IMAGE_NAME:$SUGON_ENV_IMAGE_TAG

}

# #######################################################
# 从这里开始
# #######################################################
download_depend_software
build_base_image
build_sugon_dev_image
