# Jarkom-Modul-3-E24-2023
## Anggota Kelompok
1. Daffa Zimraan Hasan (5025221223)
2. Wardatul Amalia Safitri (5025211006)

## Topologi
![topologi](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/topologi.jpg)</br>

## Soal 0
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
Lakukan uji pada salah satu client terhadap domain `granz.channel.e24.com` & `riegel.canyon.e24.com`
![1](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/1.jpg)</br>

## Soal 1
>Lakukan konfigurasi sesuai dengan peta yang sudah diberikan

### Konfigurasi Network
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

### DHCP Server
Pada Himmel (DHCP Server) buat konfigurasi untuk menetapkan ip static menggunakan konsep fixed address. Fixed address diberikan kepada worker PHP dan worker laravel
```
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
```
Dengan demikian, pembagian IP address pada worker adalah sebagai berikut : </br>
1) Lugner : 192.218.3.1
2) Linie : 192.218.3.2
3) Lawine : 192.218.3.3
4) Fern : 192.218.4.1
5) Flamme : 192.218.4.2
6) Frieren : 192.218.4.3
   
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
echo 'subnet 192.218.3.0 netmask 255.255.255.0 {
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
echo 'subnet 192.218.4.0 netmask 255.255.255.0 {
    range 192.218.4.12 192.218.4.20;
    range 192.218.4.160 192.218.4.168;
    option routers 192.218.4.0;
}' > /etc/dhcp/dhcpd.conf
```


## Soal 4
### Pertanyaan
>Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS tersebut

### Penyelesaian
Untuk menyelesaikan ini kita perlu menambahkan konfigurasi berupa `option domain-name-server` agar DNS dari Heiter dapat digunakan.
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
Selain itu, pada DNS Server (Hieter) tambahkan konfigurasi berikut agar ip client yang didapat dari dhcp server dapat terhubung dengan internet
```
echo 'options {
        directory "/var/cache/bind";

        forwarders {
                   192.168.122.1;
          };
        //dnssec-validation auto;
        allow-query{ any; };
        listen-on-v6 { any; };
};' > /etc/bind/named.conf.options
```
berikut hasilnya di salah satu client:</br>
![4a](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/4a.jpg)</br>
![4b](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/4b.jpg)</br>

## Soal 5
### Pertanyaan
>Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3
selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan
waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 96 menit

### Penyelesaian
Untuk mengatur lama waktu DHCP server meminjamkan alamat IP kepada Client dapat dilakukan dengan cara menambahkan konfigurasi berupa `lease time` pada `/etc/dhcp/dhcpd.conf` pada DHCP server.
```
echo 'subnet 192.218.3.0 netmask 255.255.255.0 {
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
Setelah itu, kita bisa mengecek apakah lama waktu DHCP server untuk meminjamkan alamat IP kepada Client yang melalui Switch3 dan switch4 sudah berubah atau belum dengan cara melihat salah satu client di masing-masing switch.
![5a](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/5a.jpg)</br>
![5b](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/5b.jpg)</br>

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
Setelah itu, clone project granz.channel.yyy.com dari link github yang sudah disiapkan sebelumnya dan masukkan folder hasil clone project ke dalam directory /var/www
```
git clone https://github.com/wamalias/granz.channel.yyy.com.git
mv granz.channel.yyy.com /var/www
```
Lalu, lakukan konfigurasi deployment pada `/etc/nginx/sites-available/granz.channel.yyy.com` pada masing-masing PHP Worker
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
Lakukan uji pada client dengan menjalankan command `lynx 192.218.3.x` untuk setiap PHP Worker.</br>
Lugner
![6-lugner](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/6-lugner.png)</br>
Linie
![6-linie](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/6-linie.png)</br>
Lawine
![6-lawine](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/6-lawine.png)</br>



## Soal 7
### Pertanyaan
>Kepala suku dari Bredt Region memberikan resource server sebagai berikut:</br>a. Lawine, 4GB, 2vCPU, dan 80 GB SSD.</br>b. Linie, 2GB, 2vCPU, dan 50 GB SSD.</br>c. Lugner 1GB, 1vCPU, dan 25 GB SSD.</br>aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000
request dan 100 request/second.

### Penyelesaian
Pembagian resources di atas akan mempengaruhi pembagian beban kerja dari masing-masing worker. Untuk menghitung total weight masing-masing node, maka nilai resources yang diberikan harus dikalikan semuanya. Tambahkan keterangan weight ini pada konfigurasi load balancer (Eisen)
```
echo '
upstream backend  {
server 192.218.3.1 weight=25; #IP Lugner
server 192.218.3.2 weight=200; #IP Linie
server 192.218.3.3 weight=640; #IP Lawine
}

server {
listen 80;
server_name _;

        location / {
                proxy_pass http://backend;
                proxy_set_header    X-Real-IP $remote_addr;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header    Host $http_host;
	}
error_log /var/log/nginx/lb_error.log;
access_log /var/log/nginx/lb_access.log;

}
' > /etc/nginx/sites-available/lb-jarkom
```
Kemudian jalankan perintah berikut pada salah satu client `ab -n 1000 -c 100 http://www.granz.channel.e24.com/`
Berikut adalah hasil testing dengan 1000 request dan 100 request/second
![7a](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/7a.jpg)</br>
![7b](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/7b.jpg)</br>

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
Untuk melakukan testing dengan Apache Benchmark, kami munggunakan syntax request sebagai berikut
```
ab -n 200 -c 10 http://granz.channel.e24.com/ 
```
Dalam soal ini kami menggunakan 5 algoritma dengan penjelasan sebagai berikut.

#### a. Round Robin
Untuk algoritma round robin, konfigurasi upstream backend pada load balancer adalah sebagai berikut
```
echo '
upstream backend  {
server 192.218.3.1; #IP Lugner
server 192.218.3.2; #IP Linie
server 192.218.3.3; #IP Lawine
}
```

#### b. Weighted Round Robin
Untuk algoritma weighted round robin, konfigurasi upstream backend pada load balancer adalah sebagai berikut
```
echo '
upstream backend  {
server 192.218.3.1 weight=25; #IP Lugner
server 192.218.3.2 weight=200; #IP Linie
server 192.218.3.3 weight=640; #IP Lawine
}
```

#### c. Least Connection
Untuk algoritma least connection, konfigurasi upstream backend pada load balancer adalah sebagai berikut
```
echo '
upstream backend  {
least_conn;
server 192.218.3.1; #IP Lugner
server 192.218.3.2; #IP Linie
server 192.218.3.3; #IP Lawine
}
```

#### d. IP Hash
Untuk algoritma IP Hash, konfigurasi upstream backend pada load balancer adalah sebagai berikut
```
echo '
upstream backend  {
ip_hash;
server 192.218.3.1; #IP Lugner
server 192.218.3.2; #IP Linie
server 192.218.3.3; #IP Lawine
}
```

#### e. Generic Hash
Untuk algoritma generic hash, konfigurasi upstream backend pada load balancer adalah sebagai berikut
```
echo '
upstream backend  {
hash $request_uri consistent;
server 192.218.3.1; #IP Lugner
server 192.218.3.2; #IP Linie
server 192.218.3.3; #IP Lawine
}
```
Dengan hasil seperti ini, maka Weighted Round Robin adalah algoritma load balancing yang paling efisien. Algoritma ini menyelesaikan tugas lebih cepat apabila dibandingkan dengan algoritma yang lain.

Untuk hasil dan laporan lebih lengkap mengenai analisis hasil testing masing masing algoritma load balancing dapat dilihat melalui grimoire kelompok kami yang dapat diakses melalui link berikut:
```https://docs.google.com/document/d/1ZhnPpZgizcKKo7t1i1oUybjh22J1jO-mBT2Hj5OpKWA/edit?usp=sharing```

## Soal 9
### Pertanyaan
>Dengan menggunakan algoritma Round Robin, lakukan testing dengan menggunakan 3
worker, 2 worker, dan 1 worker sebanyak 100 request dengan 10 request/second,
kemudian tambahkan grafiknya pada grimoire.

### Penyelesaian
Pertama-tama, setting metode pembagian beban kerja pada load balancer menggunakan algoritma round robin. Kemudian lakukan testing dengan perintah berikut
```
ab -n 100 -c 10 http://granz.channel.e24.com/ 
```
Untuk hasil dan laporan lebih lengkap mengenai analisis hasil testing masing masing untuk 3 worker, 2 worker, dan 1 worker dapat dilihat melalui grimoire kelompok kami yang dapat diakses melalui link berikut:
```https://docs.google.com/document/d/1ZhnPpZgizcKKo7t1i1oUybjh22J1jO-mBT2Hj5OpKWA/edit?usp=sharing```

## Soal 10
### Pertanyaan
>Selanjutnya coba tambahkan konfigurasi autentikasi di LB dengan dengan kombinasi
username: “netics” dan password: “ajkyyy”, dengan yyy merupakan kode kelompok.
Terakhir taruh file “htpasswd” nya di /etc/nginx/rahasisakita/

### Penyelesaian
Untuk membuat kombinasi username dan password, maka tambahkan perintah ini pada Eisen (Load Balancer)
```
mkdir -p /etc/nginx/rahasisakita/
htpasswd -bc /etc/nginx/rahasisakita/.htpasswd netics ajke24
```
Untuk menerapkan autentikasi di load balancer, maka tambahkan konfigurasi `auth_basic "Restricted"` pada Eisen (Load Balancer) dan tambahkan `auth_basic_user_file` yang mengarah ke `htpasswd` yang sudah dibuat sebelumnya
```
server {
listen 80;
server_name _;

        location / {
                proxy_pass http://backend;
                proxy_set_header    X-Real-IP $remote_addr;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header    Host $http_host;

                auth_basic "Restricted";
                auth_basic_user_file /etc/nginx/rahasisakita/.htpasswd;
	}

	location ~ /\.ht {
                deny all;
        }
error_log /var/log/nginx/lb_error.log;
access_log /var/log/nginx/lb_access.log;

}
' > /etc/nginx/sites-available/lb-jarkom
```
![10-netics](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/10-netics.png)</br>
![10-password](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/10-password.png)</br>
![10-end](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/10-end.png)</br>

## Soal 11
### Pertanyaan
>Lalu buat untuk setiap request yang mengandung /its akan di proxy passing menuju
halaman https://www.its.ac.id. (11) hint: (proxy_pass)

### Penyelesaian
Untuk mengarahkan request yang mengandung /its ke https://www.its.com, maka perlu menambahkan konfigurasi `location /its` sehingga konfigurasi server pada Eisen adalah sebagai berikut
```
server {
listen 80;
server_name _;

        location / {
                proxy_pass http://backend;
                proxy_set_header    X-Real-IP $remote_addr;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header    Host $http_host;

                auth_basic "Restricted";
                auth_basic_user_file /etc/nginx/rahasisakita/.htpasswd;
	}

 	location /its {
                proxy_pass https://www.its.ac.id;
        }

	location ~ /\.ht {
                deny all;
        }
error_log /var/log/nginx/lb_error.log;
access_log /var/log/nginx/lb_access.log;

}
' > /etc/nginx/sites-available/lb-jarkom
```
Disini kami mencoba memasukkan perintah `lynx 192.218.2.2/its` untuk testing, dan hasilnya adalah sebagai berikut
![11](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/11.png)</br>

## Soal 12
### Pertanyaan
>Selanjutnya LB ini hanya boleh diakses oleh client dengan IP [Prefix IP.3.69], [Prefix
IP.3.70], [Prefix IP.4.167], dan [Prefix IP.4.168],

### Penyelesaian
Tambahkan konfigurasi `allow IP address` dengan IP address yang diizinkan untuk akses load balancer dan `deny all` untuk block selain yang diizinkan.
```
server {
listen 80;
server_name _;

        location / {
                proxy_pass http://backend;
                proxy_set_header    X-Real-IP $remote_addr;
                proxy_set_header    X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header    Host $http_host;

                auth_basic "Restricted";
                auth_basic_user_file /etc/nginx/rahasisakita/.htpasswd;

		allow 192.218.3.69;
                allow 192.218.3.70;
                allow 192.218.4.167;
                allow 192.218.4.168;
                deny all;
	}

 	location /its {
                proxy_pass https://www.its.ac.id;
        }

	location ~ /\.ht {
                deny all;
        }
error_log /var/log/nginx/lb_error.log;
access_log /var/log/nginx/lb_access.log;

}
' > /etc/nginx/sites-available/lb-jarkom
```
![12](https://github.com/wamalias/Jarkom-Modul-3-E24-2023/raw/main/image/12.png)</br>

## Soal 13
### Pertanyaan
>Karena para petualang kehabisan uang, mereka kembali bekerja untuk mengatur
granz.channel.yyy.com.
Semua data yang diperlukan, diatur pada Denken dan harus dapat diakses oleh Frieren,
Flamme, dan Fern.

### Penyelesaian
Mula-mula lakukan instalasi mariadb-server pada Denken (Database Server)
```
apt-get update && apt-get install mariadb-server -y
```

Kemudian, tambahkna konfigurasi berikut pada Denken untuk membuat user sql
```
echo '#!/bin/bash

# MySQL connection parameters
MYSQL_USER="root"
MYSQL_PASSWORD=""
# MySQL commands
mysql -u$MYSQL_USER -p$MYSQL_PASSWORD <<EOF
CREATE USER '\''kelompokE24'\''@'\''%'\'' IDENTIFIED BY '\''passwordE24'\'';
CREATE USER '\''kelompokE24'\''@'\''localhost'\'' IDENTIFIED BY '\''passwordE24'\'';
CREATE DATABASE dbkelompokE24;
GRANT ALL PRIVILEGES ON *.* TO '\''kelompokE24'\''@'\''%'\'';
GRANT ALL PRIVILEGES ON *.* TO '\''kelompokE24'\''@'\''localhost'\'';
FLUSH PRIVILEGES;
EOF' > /run.sh
chmod +x /run.sh
./run.sh
```

dan tambahkan konfigurasi berikut pada `/etc/mysql/my.cnf`
```
echo '[mysqld]
skip-networking=0
skip-bind-address' >> /etc/mysql/my.cnf
```

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


