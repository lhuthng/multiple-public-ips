warp-cli connect
warp-cli status
sudo iptables -t nat -A POSTROUTING -o CloudflareWARP -j MASQUERADE