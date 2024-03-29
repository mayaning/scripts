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
# @file run-devel-env.sh
# @Brief 运行开发环境
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2022-12-11

set -xe

CONTAINER_IMAGES=localhost/devel-env-fedora
podman run -d --name workenv --rm \
    -v /home/mayaning/Workspace:/workspace:rw \
    $CONTAINER_IMAGES
