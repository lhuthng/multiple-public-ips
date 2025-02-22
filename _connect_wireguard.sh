sudo wg-quick up wg0
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE

sudo iptables -A FORWARD -i ens38 -o wg0 -j ACCEPT
sudo iptables -A FORWARD -i ens39 -o wg0 -j ACCEPT
sudo iptables -A FORWARD -i ens40 -o wg0 -j ACCEPT