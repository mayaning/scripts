#!/bin/bash

WINADDR=10.168.2.10
USERNAME="bingfengxiao@163.com"
PASSWD="878629bfxcle"

#xfreerdp /v:10.168.2.10     \ # 地址
#    /u:bingfengxiao@163.com \ # 用户名
#    /p:878629bfxcle         \ # 密码
#    /f                      \ # 全屏
#    +fonts                  \ # smooth fonts (ClearType) (default:on)
#    +window-drag            \ # 允许全屏拖拽
#    +clipboard              \ # 共享粘贴板
#    +menu-anims             \ # 允许菜单动画
#    +aero                   \ # Enable desktop composition
#    +glyph-cache            \ # Glyph cache (experimental) (default:off)
#    -compression            \ # 不允许压缩
#    /bpp:32                 \ # Session bpp (color depth) (default:16)
#    /gdi:hw                 \ # GDI rendering
#    /audio-mode:0           \ # Audio output mode
#    /network:lan            \ # Network connection type
#    /sound                  \ # Audio output (sound)
#    /drive:/home/mayaning   \ # 共享目录
#    /dynamic-resolution &     # Send resolution updates when the window is resized


xfreerdp /v:"$WINADDR" /u:"$USERNAME" /p:"$PASSWD" /f \
    +fonts +window-drag +clipboard +menu-anims +aero +glyph-cache  \
    -compression \
    /bpp:32 /gdi:hw /audio-mode:0 /network:auto /sound \
    /drive:/home/mayaning /dynamic-resolution &


#xfreerdp /v:"$WINADDR" /u:"$USERNAME" /p:"$PASSWD" /f \
#    +fonts +window-drag +drives +menu-anims +aero +glyph-cache +clipboard \
#    /bpp:32 /monitors:1 /network:auto  /gdi:hw /audio-mode:0 /sound &
