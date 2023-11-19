echo nameserver 192.168.122.1 > /etc/resolv.conf

apt-get update
apt-get install bind9 -y

echo '
zone "riegel.canyon.e24.com" {
        type master;
        file "/etc/bind/jarkom/riegel.canyon.e24.com";
};

zone "granz.channel.e24.com" {
        type master;
        file "/etc/bind/jarkom/granz.channel.e24.com";
};' > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom

echo '
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.e24.com root.riegel.canyon.e24.com. (
                                    2023110101    ; Serial
                        604800        ; Refresh
