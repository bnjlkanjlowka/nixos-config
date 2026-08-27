ip netns delete proxy
#nft delete table proxy_namespace
#sysctl -q net.ipv4.ip_forward=0
echo "network namespace deleted"
