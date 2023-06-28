#!/bin/bash
#/* *******************************************************
#* Copyright 2021 - 2022 Ma Yaning
#* Licensed under the Apache License, Version 2.0 (the "License");
#* you may not use this file except in compliance with the License.
#* You may obtain a copy of the License at
#* 
#*     http://www.apache.org/licenses/LICENSE-2.0
#* 
#* Unless required by applicable law or agreed to in writing, software
#* distributed under the License is distributed on an "AS IS" BASIS,
#* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#* See the License for the specific language governing permissions and
#* limitations under the License.
#* *******************************************************
#*/
#/**
#* @file create-devel-env.sh
#* @Brief 创建开发环境容器镜像的脚本
#* @author Ma Yaning, <mayaning4coding@163.com>
#* @version 0.1
#* @date 2022-12-10
#*/

set -xe

# #######################################################
# 从这里开始
# #######################################################
TMP_WORKDIR=/tmp/env-setup

step=0
echo "Create devel env from fedora:37"

# Create a container
CONTAINER=$(buildah from fedora:37)

# Labels are part of the "buildah config" command
buildah config --label maintainer="mayaning<mayaning4coding@163.com>" $CONTAINER

let step+=1
echo "Step $step: copy essential files to container"
buildah run $CONTAINER mkdir -p $TMP_WORKDIR/configs
buildah copy $CONTAINER configs $TMP_WORKDIR/configs/
buildah run $CONTAINER mkdir -p $TMP_WORKDIR/scripts
buildah copy $CONTAINER scripts $TMP_WORKDIR/scripts/
buildah run $CONTAINER mkdir -p $TMP_WORKDIR/packages
buildah copy $CONTAINER packages $TMP_WORKDIR/packages/

# 设置临时的工作目录
buildah config --workingdir $TMP_WORKDIR $CONTAINER

# 设置容器启动的endpoint
let step+=1
echo "Step $step: setup endpoint"
# Entrypoint, too, is a “buildah config” command
buildah copy $CONTAINER scripts/endpoint.sh /usr/bin
buildah run $CONTAINER chmod a+x /usr/bin/endpoint.sh
buildah config --cmd /usr/bin/endpoint.sh $CONTAINER
buildah config --env LANG=C.UTF-8 $CONTAINER

# 安装系统依赖软件
let step+=1
echo "Step $step: setup basement system env"
buildah run $CONTAINER chmod a+x $TMP_WORKDIR/scripts/setup_system_env.sh
buildah run $CONTAINER $TMP_WORKDIR/scripts/setup_system_env.sh

# 安装设置基础开发环境
let step+=1
echo "Step $step: setup coding ide"
buildah run $CONTAINER chmod a+x $TMP_WORKDIR/scripts/setup_base_env.sh
buildah run $CONTAINER $TMP_WORKDIR/scripts/setup_base_env.sh $TMP_WORKDIR

# 安装设置C语言开发环境
let step+=1
echo "Step $step: setup C language specific devel env"
buildah run $CONTAINER chmod a+x $TMP_WORKDIR/scripts/setup_c_env.sh
buildah run $CONTAINER $TMP_WORKDIR/scripts/setup_c_env.sh $TMP_WORKDIR

let step+=1
echo "Step $step: setup workingdir"
# Entrypoint, too, is a “buildah config” command
buildah config --volume /workspace $CONTAINER
buildah config --workingdir /workspace $CONTAINER

# Finally saves the running container to an image
let step+=1
echo "Step $step: Commit container image"
buildah run $CONTAINER dnf clean all
buildah run $CONTAINER rm -rf $TMP_WORKDIR
buildah commit --format docker $CONTAINER devel-env-fedora:latest

# 导出容器镜像
let step+=1
echo "Step $step: Export container image"
rm -rf devel-env-fedora.tar.gz
podman save --format docker-archive -o devel-env-fedora.tar.gz \
    devel-env-fedora:latest
