echo nameserver 192.168.122.1 > etc/resolv.conf

apt-get update
apt-get install lynx -y
apt-get install apache2-utils

echo nameserver 192.218.1.2 > /etc/resolv.conf
