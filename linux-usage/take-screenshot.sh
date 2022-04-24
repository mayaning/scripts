#!/bin/bash

IMAGE_DIR=$HOME/图片/ScreenShot
IMAGE_NAME="$IMAGE_DIR/screenshot_$(date +%F_%H-%M-%S).png"

gnome-screenshot -caf "$IMAGE_NAME"
if [ -e "$IMAGE_NAME" ]
then 
    drawing "$IMAGE_NAME"
fi
