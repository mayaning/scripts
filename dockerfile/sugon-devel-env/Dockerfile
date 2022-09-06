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
# @file Dockerfile
# @Brief: vim
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2022-08-02
#

FROM fedora:36
MAINTAINER mayaning mayaning4coding@163.com

# Install depend packages
RUN dnf upgrade -y
RUN dnf group install -y "Development Tools"
RUN dnf install -y net-tools vim telnet python clang clang-libs clang-devel \
     boost boost-devel cmake python3-devel golang cscope ctags nodejs yarnpkg

COPY vim/dot.vimrc /root/.vimrc
COPY vim/dot.vim /root/.vim

WORKDIR /root/.vim/bundle/coc.nvim
RUN yarn
RUN vim -m "+CocInstall coc-clangd" "+q" "+q"
RUN vim -m "+CocInstall coc-rust-analyzer" "+q" "+q"

COPY endpoint.sh /usr/bin
RUN chmod a+x /usr/bin/endpoint.sh
CMD ["/usr/bin/endpoint.sh"]
ENV LANG=C.UTF-8

VOLUME /workspace
WORKDIR /workspace
