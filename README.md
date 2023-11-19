# Jarkom-Modul-3-E24-2023
## Anggota Kelompok
1. Daffa Zimraan Hasan (5025221223)
2. Wardatul Amalia Safitri (5025211006)

## Topologi

## Konfigurasi <br>
Aura (DHCP Relay)
```
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
	address 192.218.1.0
	netmask 255.255.255.0

auto eth2
iface eth2 inet static
	address 192.218.2.0
	netmask 255.255.255.0

auto eth3
iface eth3 inet static
	address 192.218.3.0
	netmask 255.255.255.0

auto eth4
iface eth4 inet static
	address 192.218.4.0
	netmask 255.255.255.0

```

Himmel (DHCP Server)
```
auto eth0
iface eth0 inet static
	address 192.218.1.1
	netmask 255.255.255.0
	gateway 192.218.1.0
```

Heiter (DNS Server)
```
auto eth0
iface eth0 inet static
	address 192.218.1.2
	netmask 255.255.255.0
	gateway 192.218.1.0
```

Denken (Database Server)
```
auto eth0
iface eth0 inet static
	address 192.218.2.1
	netmask 255.255.255.0
	gateway 192.218.2.0
```

Eisen (Load Balancer)
```
auto eth0
iface eth0 inet static
	address 192.218.2.2
	netmask 255.255.255.0
	gateway 192.218.2.0
```

Fern (Laravel Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 86:3b:cb:30:7e:ac
```

Flamme (Laravel Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 86:dd:94:b6:c5:6a
```

Frieren (Laravel Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 12:36:43:eb:eb:a2
```

Lugner (PHP Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 96:78:85:aa:ff:0c
```

Linie (PHP Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether da:1b:14:4a:db:af
```

Lawine (PHP Worker)
```
auto eth0
iface eth0 inet dhcp
hwaddress ether 0a:65:f2:fc:cc:4b
```

Richter (Client)
```
auto eth0
iface eth0 inet dhcp
```

Revolte (Client)
```
auto eth0
iface eth0 inet dhcp
```

Stark (Client)
```
auto eth0
iface eth0 inet dhcp
```

Sein (Client)
```
auto eth0
iface eth0 inet dhcp
```

## Soal 1
### Pertanyaan
>Setelah mengalahkan Demon King, perjalanan berlanjut. Kali ini, kalian diminta untuk
melakukan register domain berupa riegel.canyon.yyy.com untuk worker PHP dan
granz.channel.yyy.com untuk worker Laravel (0) mengarah pada worker yang memiliki IP
[prefix IP].x.1. Lakukan konfigurasi sesuai dengan peta yang sudah diberikan. (1)

### Penyelesaian
untuk melakukan register domain berupa riegel.canyon.e24.com untuk worker Laravel dan granz.channel.e24.com untuk worker PHP yang mengarah pada worker yang memiliki IP 192.218.x.1 dapat dilakukan dengan cara menambahkan script berikut ke `/etc/bind/named.conf.local` pada DNS Server.
```
echo 'zone "riegel.canyon.e24.com" {
    type master;
    file "/etc/bind/sites/riegel.canyon.e24.com";
};

zone "granz.channel.e24.com" {
    type master;
    file "/etc/bind/sites/granz.channel.e24.com";
};' > /etc/bind/named.conf.local
```
Setelah itu kita buat directory baru yaitu `/etc/bind/jarkom` lalu membuat konfigurasi baru di `/etc/bind/jarkom/granz.channel.e24.com` dan `/etc/bind/jarkom/riegel.canyon.e24.com`.
```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     riegel.canyon.e24.com. root.riegel.canyon.e24.com. (
			2023110101	; Serial
                        604800         ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
@           IN      NS      riegel.canyon.e24.com.
@           IN      A       192.218.4.1 ; 
www         IN      CNAME   riegel.canyon.e24.com.
```
```
;
; BIND data file for local loopback interface
;
$TTL    604800
@       IN      SOA     granz.channel.e24.com. root.granz.channel.e24.com. (
                            2023110101         ; Serial
                        604800         ; Refresh
                        86400         ; Retry
                        2419200         ; Expire
                        604800 )       ; Negative Cache TTL
;
@           IN      NS      granz.channel.e24.com.
@           IN      A       192.218.3.1 ; 
www         IN      CNAME   granz.channel.e24.com.
```
Setelah itu lakukan konfigurasi di `/etc/bind/named.conf.options`.
```
echo 'options {
      directory "/var/cache/bind";

      forwarders {
              192.168.122.1;
      };

      // dnssec-validation auto;
      allow-query{any;};
      listen-on-v6 { any; };
}; ' >/etc/bind/named.conf.options
```

## Soal 2
### Pertanyaan
>Semua CLIENT harus menggunakan konfigurasi dari DHCP Server. Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32 dan [prefix IP].3.64 - [prefix IP].3.80

### Penyelesaian
Untuk menyelesaikan ini, pertama-tama kita perlu melakukan setup pada DHCP Server terlebih dahulu.
```
echo 'nameserver 192.168.122.2' > /etc/resolv.conf    
apt-get update -y
apt install isc-dhcp-server -y
```
Setelah selesai melakukan setup pada DHCP server kemudian, setup **INTERFACESv4** menuju eth0 melalui `/etc/default/isc-dhcp-server`
```
echo '
INTERFACESv4="eth0"
INTERFACESv6=' > /etc/default/isc-dhcp-server
```
Setelah itu, lakukan konfigurasi pada `/etc/dhcp/dhcpd.conf` pada DHCP server.
```
echo 'subnet 192.218.1.0 netmask 255.255.255.0 {
}

subnet 192.218.2.0 netmask 255.255.255.0 {
}

subnet 192.218.3.0 netmask 255.255.255.0 {
    range 192.218.3.16 192.218.3.32;
    range 192.218.3.64 192.218.3.80;
    option routers 192.218.3.0;
}' > /etc/dhcp/dhcpd.conf
```



## Soal 3
### Pertanyaan
>Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20 dan [prefix IP].4.160 - [prefix IP].4.168

### Penyelesaian
Kita dapat menambahkan konfigurasi seperti soal no 2 di `/etc/dhcp/dhcpd.conf` pada DHCP server, kali ini melalui switch 4.
```
subnet 192.218.4.0 netmask 255.255.255.0 {
    range 192.218.4.12 192.218.4.20;
    range 192.218.4.160 192.218.4.168;
    option routers 192.218.4.0;
}' > /etc/dhcp/dhcpd.conf
```


## Soal 4
### Pertanyaan
>Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut

### Penyelesaian
Untuk menyelesaikan ini kita perlu menambahkan konfigurasi berupa `option broadcast-address` dan `option domain-name-server` agar DNS dari Heiter dapat digunakan.
```
echo 'subnet 192.218.1.0 netmask 255.255.255.0 {
}

subnet 192.218.2.0 netmask 255.255.255.0 {
}

subnet 192.218.3.0 netmask 255.255.255.0 {
    range 192.218.3.16 192.218.3.32;
    range 192.218.3.64 192.218.3.80;
    option routers 192.218.3.0;
    option broadcast-address 192.218.3.255;
    option domain-name-servers 192.218.1.2;
}

subnet 192.218.4.0 netmask 255.255.255.0 {
    range 192.218.4.12 192.218.4.20;
    range 192.218.4.160 192.218.4.168;
    option routers 192.218.4.0;
    option broadcast-address 192.218.4.255;
    option domain-name-servers 192.218.1.2;
}' > /etc/dhcp/dhcpd.conf
```
Langkah Berikutnya, menyiapkan setup untuk DHCP Relay terlebih dahulu sebagai berikut
```
apt-get update
apt-get install isc-dhcp-relay -y

echo '
SERVERS="192.218.1.1"
INTERFACES="eth1 eth2 eth3 eth4"
OPTIONS=' > /etc/default/isc-dhcp-relay

echo 'net.ipv4.ip_forward=1' > /etc/sysctl.conf

service isc-dhcp-relay start
```

## Soal 5
### Pertanyaan
>Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3
selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan
waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 96 menit

### Penyelesaian
Untuk mengatur lama waktu DHCP server meminjamkan alamat IP kepada Client dapat dilakukan dengan cara menambahkan konfigurasi berupa `lease time` pada `/etc/dhcp/dhcpd.conf` pada DHCP server.
```
echo 'subnet 192.218.1.0 netmask 255.255.255.0 {
}

subnet 192.218.2.0 netmask 255.255.255.0 {
}

subnet 192.218.3.0 netmask 255.255.255.0 {
    range 192.218.3.16 192.218.3.32;
    range 192.218.3.64 192.218.3.80;
    option routers 192.218.3.0;
    option broadcast-address 192.218.3.255;
    option domain-name-servers 192.218.1.2;
    default-lease-time 180;
    max-lease-time 5760;
}

subnet 192.218.4.0 netmask 255.255.255.0 {
    range 192.218.4.12 192.218.4.20;
    range 192.218.4.160 192.218.4.168;
    option routers 192.218.4.0;
    option broadcast-address 192.218.4.255;
    option domain-name-servers 192.218.1.2;
    default-lease-time 720;
    max-lease-time 5760;
}' > /etc/dhcp/dhcpd.conf
```
## Soal 6
### Pertanyaan
>Berjalannya waktu, petualang diminta untuk melakukan deployment.
Pada masing-masing worker PHP, lakukan konfigurasi virtual host untuk website berikut
dengan menggunakan php 7.4.

### Penyelesaian
Lakukan setup terlebih dahulu pada masing-masing PHP Worker sebagai berikut.
```
echo 'nameserver 192.168.122.1' > /etc/resolv.conf
echo 'nameserver 192.218.1.2' >> /etc/resolv.conf
apt-get update
apt-get install nginx -y
apt-get install git -y
apt-get install php7.3 php7.3-fpm -y
apt-get install htop -y

service nginx start
service php7.3-fpm start
```
Setelah itu, silakan melakukan konfigurasi sebagai berikut.
```
git clone https://github.com/wamalias/granz.channel.yyy.com.git
mv granz.channel.yyy.com /var/www
```
Lalu, lakukan konfigurasi pada `/etc/nginx/sites-available/granz.channel.yyy.com` pada masing-masing PHP Worker
```
server {
        listen 80;
        root /var/www/granz.channel.yyy.com;
        index index.php index.html index.htm;
	server_name granz.channel.e24.com;

        location / {
                try_files $uri $uri/ /index.php?$query_string;
        }

        location ~ \.php$ {
            include snippets/fastcgi-php.conf;
            fastcgi_pass unix:/run/php/php7.3-fpm.sock;
        }

	location ~ /\.ht {
            deny_all;
        }

	error_log /var/log/nginx/jarkom_error.log;
	access_log /var/log/nginx/jarkom_access.log;
}
```

## Soal 7
### Pertanyaan
>Kepala suku dari Bredt Region memberikan resource server sebagai berikut:</br>a. Lawine, 4GB, 2vCPU, dan 80 GB SSD.</br>b. Linie, 2GB, 2vCPU, dan 50 GB SSD.</br>c. Lugner 1GB, 1vCPU, dan 25 GB SSD.</br>aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000
request dan 100 request/second.

### Penyelesaian


## Soal 8
### Pertanyaan
>Karena diminta untuk menuliskan grimoire, buatlah analisis hasil testing dengan 200
request dan 10 request/second masing-masing algoritma Load Balancer dengan
ketentuan sebagai berikut:
a. Nama Algoritma Load Balancer
b. Report hasil testing pada Apache Benchmark
c. Grafik request per second untuk masing masing algoritma.
d. Analisis

### Penyelesaian

## Soal 9
### Pertanyaan
>Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3
worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second,
kemudian tambahkan grafiknya pada grimoire.

### Penyelesaian

## Soal 10
### Pertanyaan
>Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi
username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok.
Terakhir taruh file “htpasswd” nya di /etc/nginx/rahasisakita/

### Penyelesaian

## Soal 11
### Pertanyaan
>Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju
halaman https://www.its.ac.id. (11) hint: (proxy_pass)

### Penyelesaian

## Soal 12
### Pertanyaan
>Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP.3.69], [Prefix
IP.3.70], [Prefix IP.4.167], dan [Prefix IP.4.168],

### Penyelesaian

## Soal 13
### Pertanyaan
>Karena para petualang kehabisan uang, mereka kembali bekerja untuk mengatur
granz.channel.yyy.com.
Semua data yang diperlukan, diatur pada Denken dan harus dapat diakses oleh Frieren,
Flamme, dan Fern.

### Penyelesaian

## Soal 14
### Pertanyaan
>Frieren, Flamme, dan Fern memiliki Granz Channel sesuai dengan quest guide berikut

### Penyelesaian

## Soal 15
### Pertanyaan
>Granz Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request
dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire.
a. POST /auth/register

### Penyelesaian

## Soal 16
### Pertanyaan
>Granz Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request
dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire.
b. POST /auth/login (16)

### Penyelesaian

## Soal 17
### Pertanyaan
>Granz Channel memiliki beberapa endpoint yang harus ditesting sebanyak 100 request
dengan 10 request/second. Tambahkan response dan hasil testing pada grimoire.
c. GET /me (17)


### Penyelesaian


## Soal 18
### Pertanyaan
>Untuk memastikan ketiganya bekerja sama secara adil untuk mengatur Granz Channel
maka implementasikan Proxy Bind pada Eisen untuk mengaitkan IP dari Frieren,
Flamme, dan Fern.

### Penyelesaian

## Soal 19
### Pertanyaan
>Untuk meningkatkan performa dari Worker, coba implementasikan PHP-FPM pada
Frieren, Flamme, dan Fern. Untuk testing kinerja naikkan
- pm.max_children
- pm.start_servers
- pm.min_spare_servers
- pm.max_spare_servers
sebanyak tiga percobaan dan lakukan testing sebanyak 100 request dengan 10
request/second kemudian berikan hasil analisisnya pada Grimoire

### Penyelesaian

## Soal 20
### Pertanyaans
>Nampaknya hanya menggunakan PHP-FPM tidak cukup untuk meningkatkan performa
dari worker maka implementasikan Least-Conn pada Eisen. Untuk testing kinerja dari
worker tersebut dilakukan sebanyak 100 request dengan 10 request/second.


### Penyelesaian


