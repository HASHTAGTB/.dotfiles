#!/usr/bin/env/ bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/keyitdev/sddm-astronaut-theme/master/setup.sh)"
sudo sed -i 's|ConfigFile=.*|ConfigFile=Themes/pixel_sakura.conf|' /usr/share/sddm/themes/sddm-astronaut-theme/metadata.desktop
