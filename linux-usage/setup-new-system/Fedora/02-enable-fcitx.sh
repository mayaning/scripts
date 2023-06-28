#!/bin/bash

echo "#!/bin/bash" > /etc/profile.d/fcitx.sh
echo "" >> /etc/profile.d/fcitx.sh
echo "export GTK_IM_MODULE=fcitx5" >> /etc/profile.d/fcitx.sh
echo "export QT_IM_MODULE=fcitx5"  >> /etc/profile.d/fcitx.sh
echo "export XMODIFIERS=\"@im=fcitx5\"" >> /etc/profile.d/fcitx.sh
echo "export GLFW_IM_MODULE=ibus " >> /etc/profile.d/fcitx.sh
chmod a+x /etc/profile.d/fcitx.sh


