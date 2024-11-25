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
# @file take-screenshot.sh
# @Brief    Linux下截图工具
# @author Ma Yaning, <mayaning4coding@163.com>
# @version 0.1
# @date 2022-04-24
#/


# 截图的保存位置
IMAGE_DIR=$HOME/图片/ScreenShot
mkdir -p $IMAGE_DIR
# 截图的名称
IMAGE_NAME="$IMAGE_DIR/screenshot_$(date +%F_%H-%M-%S).png"

# Step 1: 使用gnome-screenshot获取截图并保存
gnome-screenshot -caf "$IMAGE_NAME"
# 判断截图成功才对截图进行编辑，有可能Step 1并未真正进行截图(比如按Esc退出了)
if [ -e "$IMAGE_NAME" ]
then 
    # Step 2: 使用drawing打开截图，进行编辑(添加文件，箭头等)
    drawing "$IMAGE_NAME"
    # Step 3: 将截图后的图片复制到粘贴板
    xclip -selection clipboard -t image/png "$IMAGE_NAME"
fi
