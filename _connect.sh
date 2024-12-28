warp-cli connect
warp-cli status
sudo sysctl -w net.ipv4.ip_forward=1
sudo iptables -t nat -A POSTROUTING -o CloudflareWARP -j MASQUERADE