echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update -y
apt-get install isc-dhcp-server -y

echo '
INTERFACESv4="eth0"
INTERFACESv6=' > /etc/default/isc-dhcp-server

echo '
subnet 192.218.1.0 netmask 255.255.255.0 {

}' > /etc/dhcp/dhcpd.conf

echo '
subnet 192.218.2.0 netmask 255.255.255.0 {

}' >> /etc/dhcp/dhcpd.conf

echo '
subnet 192.218.3.0 netmask 255.255.255.0 {
    range 192.218.3.16 192.218.3.32;
    range 192.218.3.64 192.218.3.80;
    option routers 192.218.3.0;
    option broadcast-address 192.218.3.255;
    option domain-name-servers 192.218.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}
' >> /etc/dhcp/dhcpd.conf

echo '
subnet 192.218.4.0 netmask 255.255.255.0 {
    range 192.218.4.12 192.218.4.20;
    range 192.218.4.160 192.218.4.168;
    option routers 192.218.4.0;
    option broadcast-address 192.218.4.255;
    option domain-name-servers 192.218.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}' >> /etc/dhcp/dhcpd.conf

echo '
host Lawine {
    hardware ethernet 0a:65:f2:fc:cc:4b;
    fixed-address 192.218.3.3;
}

host Linie {
    hardware ethernet da:1b:14:4a:db:af;
    fixed-address 192.218.3.2;
}

host Lugner {
    hardware ethernet 96:78:85:aa:ff:0c;
    fixed-address 192.218.3.1;
}

host Frieren {
    hardware ethernet 12:36:43:eb:eb:a2;
    fixed-address 192.218.4.3;
}

host Flamme {
    hardware ethernet 86:dd:94:b6:c5:6a;
    fixed-address 192.218.4.2;
}

host Fern {
    hardware ethernet 86:3b:cb:30:7e:ac;
    fixed-address 192.218.4.1;
}
' >> /etc/dhcp/dhcpd.conf

rm -r /var/run/dhcpd.pid
service isc-dhcp-server restart
