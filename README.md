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

## Soal 0
### Pertanyaan
>Setelah mengalahkan Demon King, perjalanan berlanjut. Kali ini, kalian diminta untuk
melakukan register domain berupa riegel.canyon.yyy.com untuk worker PHP dan
granz.channel.yyy.com untuk worker Laravel (0) mengarah pada worker yang memiliki IP
[prefix IP].x.1.

### Penyelesaian
## Soal 1
### Pertanyaan
>Lakukan konfigurasi sesuai dengan peta yang sudah diberikan.

### Penyelesaian


## Soal 2
### Pertanyaan
>Karena masih banyak spell yang harus dikumpulkan, bantulah para petualang untuk
memenuhi kriteria berikut:<br/>
1. Semua CLIENT harus menggunakan konfigurasi dari DHCP Server.
2. Client yang melalui Switch3 mendapatkan range IP dari [prefix IP].3.16 - [prefix IP].3.32
dan [prefix IP].3.64 - [prefix IP].3.80

### Penyelesaian


## Soal 3
### Pertanyaan
>Client yang melalui Switch4 mendapatkan range IP dari [prefix IP].4.12 - [prefix IP].4.20
dan [prefix IP].4.160 - [prefix IP].4.168

### Penyelesaian


## Soal 4
### Pertanyaan
>Client mendapatkan DNS dari Heiter dan dapat terhubung dengan internet melalui DNS
tersebut

### Penyelesaian

## Soal 5
### Pertanyaan
>Lama waktu DHCP server meminjamkan alamat IP kepada Client yang melalui Switch3
selama 3 menit sedangkan pada client yang melalui Switch4 selama 12 menit. Dengan
waktu maksimal yang dialokasikan untuk peminjaman alamat IP selama 96 menit

### Penyelesaian

## Soal 6
### Pertanyaan
>Berjalannya waktu, petualang diminta untuk melakukan deployment.
Pada masing-masing worker PHP, lakukan konfigurasi virtual host untuk website berikut
dengan menggunakan php 7.4.



### Penyelesaian


## Soal 7
### Pertanyaan
>Kepala suku dari Bredt Region memberikan resource server sebagai berikut:
a. Lawine, 4GB, 2vCPU, dan 80 GB SSD.
b. Linie, 2GB, 2vCPU, dan 50 GB SSD.
c. Lugner 1GB, 1vCPU, dan 25 GB SSD.
aturlah agar Eisen dapat bekerja dengan maksimal, lalu lakukan testing dengan 1000
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


