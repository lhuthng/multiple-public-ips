warp-cli connect
warp-cli status
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o CloudflareWARP -j MASQUERADE

sudo iptables -A FORWARD -i ens38 -o CloudflareWARP -j ACCEPT
sudo iptables -A FORWARD -i ens39 -o CloudflareWARP -j ACCEPT
sudo iptables -A FORWARD -i ens40 -o CloudflareWARP -j ACCEPT