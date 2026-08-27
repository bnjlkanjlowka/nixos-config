set path /etc/tproxy-xray

ip netns add proxy #create namespace
ip link add main_network type veth peer name sub_network #создаём два интерфейса виртуальных, аля патч-корд
ip link set main_network up #включаем 1ый интерфейс в основной сети, потому что изначально они в состоянии down(выключены)
ip link set sub_network netns proxy up #включаем 2ой интерфейс, и "перемещаем" его в namespace
ip netns exec proxy ip address add 192.168.100.2/24 dev sub_network #в namespace назначаем адрес для 2ого интерфейса
ip netns exec proxy ip -6 address add fd00:100::2/64 dev sub_network
ip address add 192.168.100.1/24 dev main_network #в основной сети назначаем адрес для 1ого интерфейса
ip -6 address add fd00:100::1/64 dev main_network
#nft -f $path/nft/nft.config #включаем маскарадинг из namespace см. nft.config
ip netns exec proxy ip route add default via 192.168.100.1 #делаем так, чтобы пакеты из namespace отправлялись на main_network veth, далее они по nft правилу маскарядятся и выходят в сеть
ip netns exec proxy ip -6 route add default via fd00:100::1
ip netns exec proxy ip link set lo up #включаем localhost в namespace

ip netns exec proxy ip route add local default dev lo table 100 # Добавить таблицу маршрутизации 100
ip netns exec proxy ip rule add fwmark 1 table 100 # Добавить правило для таблицы маршрутизации 100
ip netns exec proxy ip -6 route add local default dev lo table 100
ip netns exec proxy ip -6 rule add fwmark 1 table 100
ip netns exec proxy nft -f $path/nft/nft.config
echo "network namespace created"
