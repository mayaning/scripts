#!/bin/bash

xfreerdp /v:10.168.1.194 /u:bingfengxiao@163.com /p:878629bfxcle -f \
    +fonts +window-drag +clipboard +menu-anims +aero +glyph-cache \
    -compression \
    /bpp:32 /gdi:hw /audio-mode:0 /sound /drive:/home/mayaning \
    /dynamic-resolution &

