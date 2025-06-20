#!/bin/bash
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
# @file git-config.sh
# @Brief  git设置脚本
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2021-12-28
#


# 设置用户信息
git config --global user.name "mayaning"
git config --global user.email mayaning4coding@163.com

# 设置默认编辑器
git config --global core.editor vim

# 设置commit log模板
git config --global commit.template ~/.gitmessage.txt

# 设置忽略文件列表
git config --global core.excludesfile ~/.gitignore_global

# 假如你正在 Windows 上写程序，而你的同伴用的是其他系统（或相反），你可能会遇到
# CRLF 问题。 这是因为 Windows 使用回车（CR）和换行（LF）两个字符来结束一行，而
# macOS 和 Linux 只使用换行（LF）一个字符。 虽然这是小问题，但它会极大地扰乱跨
# 平台协作。许多 Windows 上的编辑器会悄悄把行尾的换行字符转换成回车和换行， 或
# 在用户按下 Enter 键时，插入回车和换行两个字符。
# Git 可以在你提交时自动地把回车和换行转换成换行，而在检出代码时把换行转换成回车
# 和换行。 你可以用 core.autocrlf 来打开此项功能。 如果是在 Windows 系统上，把它
# 设置成 true，这样在检出代码时，换行会被转换成回车和换行：
# git config --global core.autocrlf true
# 如果使用以换行作为行结束符的 Linux 或 macOS，你不需要 Git 在检出文件时进行自动
# 的转换； 然而当一个以回车加换行作为行结束符的文件不小心被引入时，你肯定想让
# Git 修正。 你可以把 core.autocrlf 设置成 input 来告诉 Git 在提交时把回车和换行
# 转换成换行，检出时不转换：
# git config --global core.autocrlf input
# 这样在 Windows 上的检出文件中会保留回车和换行，而在 macOS 和 Linux 上，以及版
# 本库中会保留换行。
# 如果你是 Windows 程序员，且正在开发仅运行在 Windows 上的项目，可以设置 false
# 取消此功能，把回车保留在版本库中：
# git config --global core.autocrlf false
git config --global core.autocrlf input

# 设置自动着色, 可用的选项为auto, always, false
git config --global color.ui auto

# 设置合并和比较工具 
git config --global merge.tool meld
git config --global diff.tool meld

# 该配置项指定 Git 运行诸如 log 和 diff 等命令所使用的分页器。 你可以把它设置成
# 用 more 或者任何你喜欢的分页器（默认用的是 less），当然也可以设置成空字符串，
# 关闭该选项：
git config --global core.pager ''

# 解决git status中文乱码
git config --global core.quotepath false
git config --global i18n.logoutputencoding utf-8
# 解决git commit中文乱码
git config --global i18n.commitencoding utf-8

# 设置长期存储密码
git config --global credential.helper store

# 解决git在windows中报错：error:invalid path
git config --global core.protectNTFS false
