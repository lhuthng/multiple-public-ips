sudo apt remove --purge ubuntu-desktop gnome-shell gdm3
sudo apt remove --purge xserver-xorg
sudo apt autoremove

sudo iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE

