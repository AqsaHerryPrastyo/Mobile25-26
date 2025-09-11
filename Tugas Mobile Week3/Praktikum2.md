# Praktikum langkah 2 dan 3 <br>

Error pada langkah 1 tersebut adalah variabel counter belum dideklarasikan sebelum digunakan di dalam while. Pada Dart, variabel harus dideklarasikan terlebih dahulu, misalnya dengan int counter = 0; sebelum while.
Jika counter belum dideklarasikan, maka akan muncul error "Undefined name 'counter'".
Solusi: Tambahkan deklarasi variabel counter sebelum while, misal: int counter = 0;<br>

Pada langkah 3 tidak terjadi error, Kode  akan mencetak nilai counter mulai dari nilai terakhir counter setelah while sebelumnya (yaitu 33), lalu terus bertambah dan mencetak hingga counter mencapai 76. Setelah itu, perulangan berhenti.