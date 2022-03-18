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
#/
##
# @file SerivceTest.sh
# @Brief    
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2022-03-18
#/


# 服务查询, 服务的格式: 
# [tag.]<service>.service[.datacenter].<domain>
dig @127.0.0.1 -p 8600 Apache.service.consul
dig @127.0.0.1 -p 8600 db1.service.consul
dig @127.0.0.1 -p 8600 db2.service.consul

dig @127.0.0.1 -p 8600 Apache.service.dc1.consul
dig @127.0.0.1 -p 8600 db1.service.dc1.consul
dig @127.0.0.1 -p 8600 db2.service.dc1.consul

dig @127.0.0.1 -p 8600 Apache.service.dc2.consul
dig @127.0.0.1 -p 8600 db1.service.dc2.consul
dig @127.0.0.1 -p 8600 db2.service.dc2.consul

# 节点查询，格式:
# <node>.node[.datacenter].<domain>
dig @127.0.0.1 -p 8600 DC1Server1.node.consul
dig @127.0.0.1 -p 8600 DC2Server1.node.consul

