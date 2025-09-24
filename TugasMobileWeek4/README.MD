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
### Langkah 1
Ketik atau salin kode program berikut ke dalam fungsi main().
~~~Dart
var halogens = {'fluorine', 'chlorine', 'bromine', 'iodine', 'astatine'};
print(halogens);
~~~

### Langkah 2
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan! Lalu perbaiki jika terjadi error.

>Hasil run
![image](/TugasMobileWeek4/IMG/Prak2,1.png)

Ketika kode dijalankan, perintah print(halogens); akan menampilkan isi set ke konsol. Set di Dart adalah koleksi yang tidak memiliki urutan dan tidak mengizinkan duplikasi.

### Langkah 3
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.
~~~Dart
var names1 = <String>{};
Set<String> names2 = {}; // This works, too.
var names3 = {}; // Creates a map, not a set.

print(names1);
print(names2);
print(names3);
~~~

>Hasil run
![image](/TugasMobileWeek4/IMG/Prak2,3.png)



## Praktikum 3: Eksperimen Tipe Data Maps
### Langkah 1
Ketik atau salin kode program berikut ke dalam fungsi main().
~~~Dart
var gifts = {
  // Key:    Value
  'first': 'partridge',
  'second': 'turtledoves',
  'fifth': 1
};

var nobleGases = {
  2: 'helium',
  10: 'neon',
  18: 2,
};

print(gifts);
print(nobleGases);
~~~

### Langkah 2
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan! Lalu perbaiki jika terjadi error.

>Hasil run
![image](/TugasMobileWeek4/IMG/Prak3,1.png)

Kode dalam Dart tersebut mendefinisikan dua variabel bertipe Map: gifts dengan kunci String ('first', 'second', 'fifth') dan nilai campuran (String 'partridge', 'turtledoves', serta integer 1), serta nobleGases dengan kunci integer (2, 10, 18) dan nilai campuran (String 'helium', 'neon', serta integer 2); saat perintah print(gifts) dan print(nobleGases) dijalankan, Dart mencetak isi kedua map ke konsol dalam format {key1: value1, key2: value2, ...}, menghasilkan output {first: partridge, second: turtledoves, fifth: 1} dan {2: helium, 10: neon, 18: 2} secara berurutan, tanpa melakukan operasi lain selain mendefinisikan dan menampilkan isi map tersebut.

### Langkah 3
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

~~~Dart
var mhs1 = Map<String, String>();
gifts['first'] = 'partridge';
gifts['second'] = 'turtledoves';
gifts['fifth'] = 'golden rings';

var mhs2 = Map<int, String>();
nobleGases[2] = 'helium';
nobleGases[10] = 'neon';
nobleGases[18] = 'argon';
~~~
>Hasil run
![image](/TugasMobileWeek4/IMG/Prak3,3.png)


gifts (kunci String, nilai dynamic) dan nobleGases (kunci int, nilai dynamic), lalu mencetaknya, diikuti dengan penambahan kode yang membuat dua map baru, mhs1 (kunci dan nilai String, kosong) dan mhs2 (kunci int, nilai String, kosong), serta mengubah nilai pada gifts (fifth dari 1 ke 'golden rings') dan nobleGases (18 dari 2 ke 'argon') tanpa menyebabkan error karena tipe dynamic mendukung perubahan tersebut; output awal menunjukkan {first: partridge, second: turtledoves, fifth: 1} dan {2: helium, 10: neon, 18: 2}, sedangkan mhs1 dan mhs2 menghasilkan {} karena kosong, dan jika gifts serta nobleGases dicetak ulang setelah perubahan, outputnya menjadi {first: partridge, second: turtledoves, fifth: golden rings} dan {2: helium, 10: neon, 18: argon}.

#### Tambahkan elemen nama dan NIM
>Hasil run
![image](/TugasMobileWeek4/IMG/Prak3,33.png)


## Praktikum 4: Eksperimen Tipe Data List: Spread dan Control-flow Operators
### Langkah 1: 
Ketik atau salin kode program berikut ke dalam fungsi main().

~~~Dart
var list = [1, 2, 3];
var list2 = [0, ...list];
print(list1);
print(list2);
print(list2.length);
~~~

### Langkha 2:
Silakan coba eksekusi (Run) kode pada langkah 1 tersebut. Apa yang terjadi? Jelaskan! Lalu perbaiki jika terjadi error.

>Hasil run
![image](/TugasMobileWeek4/IMG/Prak4,1.png)

variabel list1 tidak didefinisikan, sedangkan kode menggunakan list untuk mendefinisikan daftar [1, 2, 3].


>Hasil perbaikan
![image](/TugasMobileWeek4/IMG/Prak4,11.png)

### Langkah 3 
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

~~~Dart
list1 = [1, 2, null];
print(list1);
var list3 = [0, ...?list1];
print(list3.length);
~~~
Tambahkan variabel list berisi NIM Anda menggunakan Spread Operators. Dokumentasikan hasilnya dan buat laporannya!

>Hasil run
![image](/TugasMobileWeek4/IMG/Prak4,3.png)

### Langkah 4
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

~~~Dart
var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
print(nav);
~~~
Apa yang terjadi ? Jika terjadi error, silakan perbaiki. Tunjukkan hasilnya jika variabel promoActive ketika true dan false.

>Hasil run
![image](/TugasMobileWeek4/IMG/Prak4,4.png)

### Langkah 5
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

~~~Dart
var nav2 = ['Home', 'Furniture', 'Plants', if (login case 'Manager') 'Inventory'];
print(nav2);
~~~
Apa yang terjadi ? Jika terjadi error, silakan perbaiki. Tunjukkan hasilnya jika variabel login mempunyai kondisi lain.

>Hasil run
![image](/TugasMobileWeek4/IMG/Prak4,5.png)

### Langkah 6
Tambahkan kode program berikut, lalu coba eksekusi (Run) kode Anda.

~~~Dart
var listOfInts = [1, 2, 3];
var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
assert(listOfStrings[1] == '#1');
print(listOfStrings);
~~~
Apa yang terjadi ? Jika terjadi error, silakan perbaiki. Jelaskan manfaat Collection For dan dokumentasikan hasilnya.
>Hasil run
![image](/TugasMobileWeek4/IMG/Prak4,6.png)


Kode tersebut membuat list baru menggunakan **collection for**, di mana `listOfInts` berisi `[1, 2, 3]`, lalu `listOfStrings` dibentuk dengan menambahkan elemen tetap `'#0'` dan hasil perulangan `for (var i in listOfInts) '#$i'` sehingga menghasilkan `['#0', '#1', '#2', '#3']`; perintah `assert(listOfStrings[1] == '#1')` benar karena elemen indeks ke-1 adalah `'#1'`, dan saat dicetak tampil `[ #0, #1, #2, #3 ]`. Manfaat collection for adalah memudahkan pembuatan list secara ringkas dan deklaratif karena memungkinkan menggabungkan elemen statis dengan hasil perulangan langsung di dalam list literal tanpa harus menulis loop terpisah.
