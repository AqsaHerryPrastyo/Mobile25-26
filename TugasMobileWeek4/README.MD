# Laporan Praktikum PEMROGRAMAN MOBILE

| Nama      | NIM      | Kelas      | Mata Kuliah | Semester |
|-----------|----------|------------|-------------|----------|
| Aqsa Herry P | 2341720153 | TI-3H | PEMROGRAMAN MOBILE | 5 |

## Praktikum 1: Eksperimen Tipe Data List
### LANGKAH 1:
Ketik atau salin kode program berikut ke dalam fungsi main().

~~~Dart
var list = [1, 2, 3];
assert(list.length == 3);
assert(list[1] == 2);
print(list.length);
print(list[1]);

list[1] = 1;
assert(list[1] == 1);
print(list[1]);
~~~

### Langkah 2 
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan!

>Hasil run
![image](/TugasMobileWeek4/IMG/Prak1,1.png)

Kode ini membuat array [1, 2, 3], memeriksa panjang dan elemennya menggunakan assert, lalu mencetak panjang (3) dan elemen pada indeks 1 (2).
Kemudian, elemen pada indeks 1 diubah menjadi 1, diverifikasi dengan assert, dan dicetak kembali (1).

### Langkah 3
Ubah kode pada langkah 1 menjadi variabel final yang mempunyai index = 5 dengan default value = null. Isilah nama dan NIM Anda pada elemen index ke-1 dan ke-2. Lalu print dan capture hasilnya.

Apa yang terjadi ? Jika terjadi error, silakan perbaiki.

>Hasil run
![image](/TugasMobileWeek4/IMG/Prak1,3.png)

Kode tersebut membuat list dengan panjang 5 berisi nilai `null`, lalu elemen pada indeks ke-1 diisi dengan nama Anda dan indeks ke-2 diisi dengan NIM, sehingga saat dicetak hasilnya menjadi `[null, Herry Prastyo, 123456789, null, null]` yang menunjukkan list tetap berukuran 5, hanya saja dua indeks tersebut sudah terisi sesuai instruksi sedangkan indeks lainnya tetap bernilai `null`.


## Praktikum 2: Eksperimen Tipe Data Set
