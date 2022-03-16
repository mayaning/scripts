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
#/
##
# @file Dockerfile
# @Brief    生成Consul测试容器
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2022-03-16
#/

FROM debian:latest
MAINTAINER mayaning mayaning4coding@163.com

# 安装依赖软件
RUN apt-get -y update
RUN apt-get -y install curl software-properties-common gnupg

# 安装Consul
RUN curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
RUN apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
RUN apt-get -y update && apt-get -y install consul

COPY endpoint.sh /usr/bin
CMD ["endpoint.sh"]
