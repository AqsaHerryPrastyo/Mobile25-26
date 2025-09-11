# Laporan Praktikum PEMROGRAMAN MOBILE

| Nama      | NIM      | Kelas      | Mata Kuliah | Semester |
|-----------|----------|------------|-------------|----------|
| Aqsa Herry P | 2341720153 | TI-3H | PEMROGRAMAN MOBILE | 5 |

## 2. Praktikum 1: Menerapkan Control Flows ("if/else")
### LANGKAH 1:
Ketik atau salin kode program berikut ke dalam fungsi main().
~~~Dart
String test = "test2";
if (test == "test1") {
   print("Test1");
} else if (test == "test2") {
   print("Test2");
} else {
   print("Something else");
}

if (test == "test2") print("Test2 again");
~~~

### Langkah 2:
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan!

>Hasil Run

![Image](/TugasMobileWeek3/IMG/Praktikum1langkah1.png)

Kode ini menghasilkan output "Test2" diikuti "Test2 again" karena kondisi pertama gagal (test != "test1"), sehingga masuk ke else if yang benar (test == "test2"). Operator == membandingkan string secara langsung di Dart, yang bekerja berdasarkan kesamaan sequence karakter.

### Langkah 3:
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

~~~Dart
String test = "true";
if (test) {
   print("Kebenaran");
}
~~~

Apa yang terjadi? Jika terjadi error, silakan perbaiki namun tetap menggunakan if/else.

>Hasil error karena variabel test telah digunakan, maka variabel dapat diubah menjadi 'test2', lalu pada pengkondisian if seharusnya dirubah menjadi 'test2 == "true"'. Hasil di bawah ini

![Image](/TugasMobileWeek3/IMG/Praktikum1langkah3.png)

Error terjadi karena Dart tidak mengizinkan kondisi if langsung pada string (non-boolean); kondisi harus boolean. Perbaikan: Gunakan perbandingan eksplisit seperti test2 == "true".

## 3. Praktikum 2: Menerapkan Perulangan "while" dan "do-while"
### Langkah 1:
Ketik atau salin kode program berikut ke dalam fungsi main().

~~~Dart
while (counter < 33) {
  print(counter);
  counter++;
}
~~~

### Langkah 2:
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan! Lalu perbaiki jika terjadi error.

>Terjadi error karena counter belum dideklarasi, maka dapat ditambahkan dulu. 'int counter = 0;'. Berikut adalah hasil dijalankan

![Image](/TugasMobileWeek3/IMG/Praktikum2langkah2.png)

Error karena variabel counter tidak didefinisikan sebelum digunakan. Di Dart, variabel harus dideklarasikan terlebih dahulu. Loop while mengecek kondisi di awal setiap iterasi; inisialisasi di luar loop memulai dari 0 hingga 32.

### Langkah 3:
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

~~~Dart
do {
  print(counter);
  counter++;
} while (counter < 77);
~~~

Apa yang terjadi? Jika terjadi error, silakan perbaiki namun tetap menggunakan do-while.

>Hasil run

![Image](/TugasMobileWeek3/IMG/Praktikum2langkah3.png)

Kode akan mencetak nilai counter mulai dari nilai terakhir counter setelah while sebelumnya (yaitu 33), lalu terus bertambah dan mencetak hingga counter mencapai 76. Loop do-while menjalankan blok kode setidaknya sekali sebelum mengecek kondisi.

## 4. Praktikum 3: Menerapkan Perulangan "for" dan "break-continue"
### Langkah 1:
Ketik atau salin kode program berikut ke dalam fungsi main().

~~~Dart
for (Index = 10; index < 27; index) {
  print(Index);
}
~~~

### Langkah 2:
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan! Lalu perbaiki jika terjadi error.

>Terjadi error karena tipe data belum ditentukan pada variabel index dan increment tidak benar. Tambahkan int di depan index dan ++ pada index paling kanan agar tidak looping abadi. Hasil run di bawah ini

![Image](/TugasMobileWeek3/IMG/Praktikum3Langkah2.png)

Error karena variabel index tidak dideklarasikan dengan tipe (misalnya int) dan increment hilang, menyebabkan infinite loop. Sintaks for di Dart: for (init; condition; increment). Perbaikan: for (int index = 10; index < 27; index++).

### Langkah 3:
Tambahkan kode program berikut di dalam for-loop, lalu coba eksekusi (Run) kode Anda.

~~~dart
if (index == 21)
  break;
else if (index > 1 || index < 7)
  continue;
print(index);
~~~

>Ubah logika or menjadi and agar looping dapat tampil angka index

![Image](/TugasMobileWeek3/IMG/Praktikum3langkah3.png)

Kondisi OR (||) menyebabkan hampir semua iterasi di-skip karena index mulai dari 10 (>1). Ubah ke AND (&&) untuk skip hanya iterasi di mana index >1 DAN <7 (tidak relevan di range 10-26). Break hentikan loop di 21; continue skip iterasi saat kondisi benar.

## 5. Tugas Praktikum
Buatlah sebuah program yang dapat menampilkan bilangan prima dari angka 0 sampai 201 menggunakan Dart. Ketika bilangan prima ditemukan, maka tampilkan nama lengkap dan NIM Anda.

~~~Dart
void main(List<String> args) {
  int angka = 0;
  while (angka <= 201) {
    bool isPrima = true;
    if (angka < 2) {
      isPrima = false;
    } else {
      for (int i = 2; i <= angka ~/ 2; i++) {
        if (angka % i == 0) {
          isPrima = false;
          break;
        }
      }
    }
    if (isPrima) {
      print("$angka \nNIM: 2341720153 \nNama: Aqsa Herry P");
    } else {
      print("$angka");
    }
    angka++;
  }
}
~~~

>Hasil Run

![Image](/TugasMobileWeek3/IMG/TugasPraktikum.png)

Program ini menggunakan while untuk iterasi 0-201, dan for untuk cek prima (tidak ada pembagi selain 1 dan dirinya sendiri). Efisien karena break saat faktor ditemukan, dan loop hanya hingga n/2.