# **Proyek Akhir PSD - SISTEM ENKRIPSI RSA DENGAN RANDOM PRIME GENERATOR BERBASIS VHDL**

Oleh : 
```
Gede Rama Pradnya (2306161914)
Kelvin Ferrell Tjoe (2306205393)
Ade Zaskia Azzahra (2406344353)
Syifa Naila Maulidya (2406436940)
```

## **Latar Belakang**
Di tengah era digital saat ini, keamanan informasi telah menjadi aspek yang sangat krusial. Volume data sensitif dan pribadi yang mengalir melalui berbagai jaringan komunikasi seperti pesan teks, email, dan beragam jenis berkas sangatlah besar. Oleh karena itu, melindungi data ini adalah kebutuhan yang mendesak dan tidak bisa ditunda.

Namun, tantangan utama yang harus dihadapi adalah risiko serangan dari pihak yang tidak berwenang. Pihak-pihak ini, yang sering disebut peretas (hacker), secara terus-menerus berupaya mencuri atau merusak data tersebut. Teknik paling umum yang mereka gunakan adalah mencoba memecahkan sandi (decrypt) informasi yang sedang dikirimkan atau yang sudah tersimpan. Untuk menanggulangi ancaman serius ini, diperlukan sistem enkripsi (penguncian data) yang kuat, andal, dan efisien agar kerahasiaan dan integritas data tetap terjaga.

## **Cara Kerja**
Program ini dirancang untuk menghasilkan bilangan acak menggunakan fungsi yang didefinisikan sebagai imurni (impure) dalam berkas RandomPrimeGen.vhd. Dalam prosesnya, program akan membuat dua bilangan acak 12-bit (yang nilainya berkisar hingga 4095 dalam desimal). Kedua bilangan yang dihasilkan tersebut kemudian akan melalui proses pengecekan untuk memverifikasi status keprimaan masing-masing. Jika kedua hasil acak tersebut terbukti merupakan bilangan prima, maka keduanya akan ditetapkan sebagai variabel $p$ dan $q$ untuk digunakan lebih lanjut (misalnya, sebagai kunci dalam sistem kriptografi).

### **Control Unit**
Program VHDL ini merupakan implementasi yang mendefinisikan entitas dan arsitektur yang membentuk sebuah unit kontrol sederhana. Entitas utamanya, yang disebut "**Sender**," memiliki dua port komunikasi yaitu **clk** sebagai input clock, dan **prime1_receiver** dan **prime2_receiver** sebagai buffer untuk bilangan prima yang diterima. Terdapat juga output untuk **outCurr**, **outputEncrypt**, dan **outputDecrypt**. 

Arsitektur **rtl** (register-transfer level) mendefinisikan komponen **DecryptorUnit** yang berfungsi untuk menerima pesan, mengenkripsi, dan mendekripsi data sesuai dengan kunci yang diterima. Proses ini akan dijalankan dengan menggunakan clock sebagai sinyal pengatur waktu, yang memastikan setiap proses enkripsi dan dekripsi berjalan sesuai urutan state yang telah ditentukan.

### **Key Generator**
Program VHDL ini mengimplementasikan entitas "KeyGen" yang bertugas utama menghasilkan pasangan kunci publik (public key) dan kunci privat (private key), didasarkan pada bilangan prima **prime1_key** dan **prime2_key**. Komponen utama program ini adalah process yang dipicu pada setiap tepi naik sinyal jam ($clk$). Di dalam process ini, terdapat sub komponen lain bernama RandomPrimeGen, yang berfungsi khusus untuk menghasilkan dua bilangan prima acak yang akan menjadi **prime1_key** dan **prime2_key**.

Selanjutnya, process utama tersebut melakukan serangkaian perhitungan matematis (sesuai algoritma yang diterapkan, kemungkinan RSA) untuk menentukan kunci enkripsi ($e$) dan kunci dekripsi ($d$). Hasil perhitungan ini kemudian disimpan dalam sinyal **encryption_key** dan **decryption_key**. 

Program ini juga menyediakan komentar yang menunjukkan tempat untuk menambahkan logika tambahan, seperti perhitungan kunci privat (**d**), yang mungkin diperlukan dalam implementasi kriptografi yang lebih kompleks. Secara singkat, tujuan dari program ini adalah untuk menghasilkan kunci publik dan privat yang digunakan dalam algoritma kriptografi, di mana kunci publik digunakan untuk enkripsi dan kunci privat digunakan untuk dekripsi.

### **Prime Generator**
Program **RandomPrimeGen.vhd** ini dirancang untuk menghasilkan dua bilangan prima (**p** dan **q**) berdasarkan sinyal clock (**clk**). Program ini menggunakan metode **trial division** untuk memastikan bahwa angka yang dihasilkan adalah bilangan prima. Dalam implementasinya, program ini menggunakan proses yang diaktifkan pada setiap rising edge dari sinyal clock. Dalam proses ini, variabel seperti **seed1**, **seed2**, **rand_int1**, dan **rand_int2** diinisialisasi, yang diperlukan untuk menghasilkan angka acak.

Program ini memiliki fungsi **rand_int_gen** yang menghasilkan bilangan acak dalam rentang yang ditentukan. Fungsi ini menggunakan nilai **seed** dan fungsi **uniform** dari paket **IEEE.math_real** untuk menghasilkan nilai acak antara 0 dan 1, yang kemudian dikonversi menjadi integer dalam rentang yang ditentukan.

Pada setiap siklus pemrosesan, program menghasilkan dua angka acak (**rand_int1** dan **rand_int2**). Selanjutnya, program menggunakan metode **trial division** untuk memeriksa apakah kedua angka tersebut adalah bilangan prima. Proses ini dilakukan dengan membagi setiap angka dengan angka-angka mulai dari 2 hingga akar kuadrat dari angka tersebut. Jika ditemukan pembagi yang membagi habis, maka angka tersebut bukan bilangan prima.

Proses ini diulang hingga kedua angka yang dihasilkan benar-benar merupakan bilangan prima. Setelah itu, kedua bilangan prima tersebut disalin ke output **p** dan **q**. Secara ringkas, tujuan dari program ini adalah untuk menghasilkan dua bilangan prima (**p** dan **q**) sebagai output berdasarkan sinyal clock, dengan memastikan bahwa angka tersebut benar-benar bilangan prima melalui metode percobaan dan kesalahan.

---

## **Fungsi `rand_int_gen` pada PrimeGen.vhd**
Pada bagian **RandomPrimeGen.vhd**, fungsi **rand_int_gen** berfungsi untuk menghasilkan angka acak dalam rentang tertentu. Berikut adalah kode untuk menghasilkan angka acak:

```vhdl
impure function rand_int_gen(min: integer; max: integer) return integer is
    variable randomValue: real;
begin
    uniform(seed1, seed2, randomValue);
    return integer(round(randomValue * real(max - min + 1) + real(min) - 0.5));
end function;
```

- **Penjelasan**: 
  - Fungsi **rand_int_gen** menghasilkan angka acak dalam rentang yang ditentukan oleh `min` dan `max`.
  - Fungsi **uniform(seed1, seed2, randomValue)** dari paket **IEEE.math_real** digunakan untuk menghasilkan nilai acak antara 0 dan 1.
  - Kemudian nilai acak ini dikalikan dengan rentang yang diinginkan (dari `min` hingga `max`), dan hasilnya dibulatkan ke integer terdekat.

---

## **Cara Penggunaan**
Program kami bekerja untuk mengenkripsi dan mendekripsi pesan. Pada **Sender.vhd**, Anda akan diberikan sebuah pesan dalam bentuk string yang terdiri dari 10 huruf kapital, masing-masing dipisahkan oleh spasi. Pesan tersebut akan diproses oleh program utama **Receiver.vhd**.

## **State Diagram Program**
![image](https://hackmd.io/_uploads/HkJcFAa-We.png)

## **Block Diagram Program**
![image](https://hackmd.io/_uploads/Bk3sKRT-Ze.png)

## **Pengujian**
Untuk menguji enkripsi dan dekripsi pesan ini, gunakan file **Sender.vhd** yang berfungsi sebagai testbench. Pada file **Sender**, Anda akan diberikan pesan dalam bentuk string yang terdiri dari 10 huruf kapital, masing-masing dipisahkan oleh spasi. Pesan ini kemudian diproses oleh program utama **Receiver.vhd**.

## **Hasil Wave Simulasi**
### **Sender.vhd**
![Sender](https://hackmd.io/_uploads/Sy2U-vZzWg.jpg)

### **Receiver.vhd**
![Receiver](https://hackmd.io/_uploads/SJBwbwbGbl.jpg)

### **RandomPrimeGen.vhd**
![RandomPrimeGen](https://hackmd.io/_uploads/ByfubvbzWl.jpg)

### **KeyGen.vhd**
![KeyGen](https://hackmd.io/_uploads/S1wKWP-zWg.jpg)

