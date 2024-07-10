#!/bin/bash

echo "#!/bin/bash" > /etc/profile.d/fcitx.sh
echo "" >> /etc/profile.d/fcitx.sh
echo "export GTK_IM_MODULE=fcitx5" >> /etc/profile.d/fcitx.sh
echo "export QT_IM_MODULE=fcitx5"  >> /etc/profile.d/fcitx.sh
echo "export XMODIFIERS=\"@im=fcitx5\"" >> /etc/profile.d/fcitx.sh
echo "export GLFW_IM_MODULE=ibus " >> /etc/profile.d/fcitx.sh
chmod a+x /etc/profile.d/fcitx.sh

#KDE: "虚拟键盘" 里选定fcitx
echo "KDE: '设置'->'键盘'->'虚拟键盘'中选择'Fcitx5 Wayland启动器'"

