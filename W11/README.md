| Nama      | NIM      | Kelas      | Mata Kuliah | Semester |
|-----------|----------|------------|-------------|----------|
| Aqsa Herry P | 2341720153 | TI-3H | PEMROGRAMAN MOBILE | 5 |

# Pemrograman Asynchronous di FlutterPemrograman Asynchronous di Flutter

## Praktikum 1: Mengunduh Data dari Web Service (API)

### Langkah 1: Buat Project Baru
Buatlah sebuah project flutter baru dengan nama books di folder src week-11 repository GitHub Anda.

Kemudian Tambahkan dependensi http dengan mengetik perintah berikut di terminal.

flutter pub add http

### Langkah 2: Cek file pubspec.yaml
Jika berhasil install plugin, pastikan plugin http telah ada di file pubspec ini seperti berikut.

dependencies:
~~~Dart
  flutter:
    sdk: flutter
  http: ^1.1.0
  ~~~
Jika Anda menggunakan macOS, Anda harus mengaktifkan fitur networking pada file macos/Runner/DebugProfile.entitlements dan macos/Runner/Release.entitlements dengan menambahkan kode berikut:
~~~
<key>com.apple.security.network.client</key>
<true/>
~~~

#### Langkah 3: Buka file main.dart
Ketiklah kode seperti berikut ini.

Soal 1
Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.
~~~Dart
import dart:async';
import 'package:flutter/material.dart';
import package:http/http.dart";
import 'package:http/http.dart' as http;
void main() {
}
runApp(const MyApp());
class MyApp extends StatelessWidget {
const MyApp({super.key});
@override
Widget build(BuildContext context) {
return MaterialApp(
);
title: 'Future Demo',
theme: ThemeData(
),
primarySwatch: Colors.blue,
visualDensity: Visual Density.adaptivePlatformDensity,
home: const FuturePage(),
);
}
}
class FuturePage extends StatefulWidget {
const FuturePage({super.key});
}
@override
State FuturePage> createState() => _FuturePageState();
class FuturePageState extends State FuturePage> {
String result = '';
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar (
),
title: const Text('Back from the Future'),
body: Center (
child: Column(children: [
const Spacer(),
ElevatedButton(
),
child: const Text('GO!'),
onPressed: () {},
const Spacer(),
Text(result),
const Spacer(),
const CircularProgress Indicator(),
const Spacer(),
]),
),
);
}
~~~
Catatan:

Tidak ada yang spesial dengan kode di main.dart tersebut. Perlu diperhatikan di kode tersebut terdapat widget CircularProgressIndicator yang akan menampilkan animasi berputar secara terus-menerus, itu pertanda bagus bahwa aplikasi Anda responsif (tidak freeze/lag). Ketika animasi terlihat berhenti, itu berarti UI menunggu proses lain sampai selesai.

### Langkah 4: Tambah method getData()
Tambahkan method ini ke dalam class _FuturePageState yang berguna untuk mengambil data dari API Google Books.
~~~Dart
Future<Response> getData() async {
const authority = 'www.googleapis.com';
const path = */books/v1/volumes/junbDwAAQBAJ';
Uri url = Uri.https (authority, path);
return http.get(url);
}
~~~

Soal 2
Carilah judul buku favorit Anda di Google Books, lalu ganti ID buku pada variabel path di kode tersebut. Caranya ambil di URL browser Anda seperti gambar berikut ini.


Kemudian cobalah akses di browser URI tersebut dengan lengkap seperti ini. Jika menampilkan data JSON, maka Anda telah berhasil. Lakukan capture milik Anda dan tulis di README pada laporan praktikum. Lalu lakukan commit dengan pesan "W11: Soal 2".

![img](/W11/img/Soal2.png)

Langkah 5: Tambah kode di ElevatedButton
Tambahkan kode pada onPressed di ElevatedButton seperti berikut.
~~~Dart
ElevatedButton(
child: Text('GO!'),
onPressed: (){
setState(() {});
getData()
.then((value) {
result = value.body.toString().substring(0, 450);
setState(() {});
}).catchError((_){
result = 'An error occurred';
setState(() {});
});
},
),
~~~
Lakukan run aplikasi Flutter Anda. Anda akan melihat tampilan akhir seperti gambar berikut. Jika masih terdapat error, silakan diperbaiki hingga bisa running.

Soal 3
Jelaskan maksud kode langkah 5 tersebut terkait substring dan catchError!
Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W11: Soal 3".

## Jawaban Soal 3

- Penjelasan substring(0, 450):
  - Fungsi `substring(0, 450)` mengambil 450 karakter pertama dari respon HTTP agar tampilan di aplikasi tetap ringkas dan tidak membebani UI dengan data JSON yang sangat panjang. Ini berguna untuk preview cepat. Namun, jika panjang body kurang dari 450 karakter, pemanggilan `substring(0, 450)` tanpa pemeriksaan akan menyebabkan `RangeError`.
  - Cara yang lebih aman:

```dart
final body = value.body.toString();
result = body.length > 450 ? body.substring(0, 450) : body;
```

- Penjelasan catchError((_):
  - `.catchError(...)` menangani error yang mungkin terjadi saat Future gagal (mis. masalah jaringan, timeout, atau exception lain). Dengan menggunakan `catchError` kita bisa menampilkan pesan user-friendly (mis. "An error occurred") dan mencegah aplikasi crash.
  - Parameter `_` biasa digunakan ketika kita tidak memerlukan detail error; untuk debugging sebaiknya tampilkan atau log error tersebut.

  ![img](/W11/img/Soal3.png)

 ## Praktikum 2: Menggunakan await/async untuk menghindari callbacks
Pada codelab ini, kita akan menambah kode dari aplikasi books di praktikum sebelumnya.


### Langkah 1: Buka file main.dart
Tambahkan tiga method berisi kode seperti berikut di dalam class _FuturePageState.
~~~Dart
Future<int> returnOneAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 1;
}

Future<int> returnTwoAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 2;
}

Future<int> returnThreeAsync() async {
  await Future.delayed(const Duration(seconds: 3));
  return 3;
}
~~~

### Langkah 2: Tambah method count()
Lalu tambahkan lagi method ini di bawah ketiga method sebelumnya.

~~~Dart
Future count() async {
int total = 0;
total = await returnOneAsync();
total += await returnTwoAsync();
total += await return ThreeAsync();
setState(() {
result = total.toString();
});
}
~~~

### Langkah 3: Panggil count()
Lakukan comment kode sebelumnya, ubah isi kode onPressed() menjadi seperti berikut.

~~~Dart
ElevatedButton(
child: Text('GO!'),
onPressed: () {
count();
},
}
~~~

### Langkah 4: Run
Akhirnya, run atau tekan F5 jika aplikasi belum running. Maka Anda akan melihat seperti gambar berikut, hasil angka 6 akan tampil setelah delay 9 detik.

![img](/W11/img/W11Prak2.gif)

Soal 4
Jelaskan maksud kode langkah 1 dan 2 tersebut!

### Jawaban Soal 4

- Maksud kode Langkah 1 (tiga method async):
  - Ketiga fungsi `returnOneAsync()`, `returnTwoAsync()`, dan `returnThreeAsync()` adalah fungsi asynchronous yang menggunakan `async` dan mengembalikan `Future<int>`.
  - Pada setiap fungsi digunakan `await Future.delayed(const Duration(seconds: 3));` — ini mensimulasikan operasi asynchronous (mis. network/disk) yang berlangsung 3 detik sebelum mengembalikan nilai (1, 2, atau 3).

- Maksud kode Langkah 2 (`count()`):
  - Fungsi `count()` memanggil ketiga fungsi di atas secara berurutan menggunakan `await`. Karena pemanggilan `await` dilakukan satu per satu, eksekusi bersifat serial sehingga total waktu kira-kira 3s + 3s + 3s = 9 detik.
  - Setelah semua Future selesai, `count()` menjumlahkan hasilnya dan memanggil `setState()` untuk memperbarui UI (mis. menampilkan "6").

- Inti pembelajaran:
  - `async`/`await` membuat alur asynchronous lebih mudah dibaca daripada callback/then.
  - `await` tidak mem-block UI thread; ia hanya menunda eksekusi fungsi sampai Future selesai, sementara event loop tetap berjalan.
  - `setState()` diperlukan untuk memberi tahu Flutter agar merender ulang widget setelah state berubah.

- Catatan performa & alternatif:
  - Jika tujuan adalah menjalankan ketiga operasi sekaligus (paralel) dan menunggu semuanya selesai, gunakan `Future.wait([...])`. Contoh:
    ```dart
    final results = await Future.wait([returnOneAsync(), returnTwoAsync(), returnThreeAsync()]);
    final total = results.reduce((a, b) => a + b);
    ```
    Dengan ini total waktu mendekati 3 detik, bukan 9 detik, karena ketiganya berjalan bersamaan.


## Praktikum 3: Menggunakan Completer di Future

## #Langkah 1: Buka main.dart
Pastikan telah impor package async berikut.
~~~Dart
import 'package:async/async.dart';
~~~

### Langkah 2: Tambahkan variabel dan method
Tambahkan variabel late dan method di class _FuturePageState seperti ini.
~~~Dart
late Completer completer;

Future getNumber() {
  completer = Completer<int>();
  calculate();
  return completer.future;
}

Future calculate() async {
  await Future.delayed(const Duration(seconds : 5));
  completer.complete(42);
}
~~~

### Langkah 3: Ganti isi kode onPressed()
Tambahkan kode berikut pada fungsi onPressed(). Kode sebelumnya bisa Anda comment.
~~~Dart
getNumber().then((value) {
setState(() {
result = value.toString();
});
});
~~~
### Langkah 4:
Terakhir, run atau tekan F5 untuk melihat hasilnya jika memang belum running. Bisa juga lakukan hot restart jika aplikasi sudah running. Maka hasilnya akan seperti gambar berikut ini. Setelah 5 detik, maka angka 42 akan tampil.

![img](/W11/img/W11Prak3.gif)

### Soal 5
Jelaskan maksud kode langkah 2 tersebut!
completer = Completer<int>(); membuat controller untuk sebuah Future yang akan diselesaikan nanti.
getNumber() mengembalikan completer.future lalu memanggil calculate() — jadi pemanggil mendapat Future yang belum selesai.
calculate() menunggu 5 detik lalu memanggil completer.complete(42); — ini menyelesaikan Future dan mengirim nilai 42 ke pemanggil.
Dengan getNumber().then((v) { setState(() => result = v.toString()); }); UI akan di-update ketika Future tersebut selesai.

### Langkah 5: Ganti method calculate()
Gantilah isi code method calculate() seperti kode berikut, atau Anda dapat membuat calculate2()
~~~Dart
calculate() async {
try {
await new Future.delayed (const Duration(seconds: 5));
completer.complete(42);
// throw Exception();
}
catch () {
completer.completeError({});
}
}
~~~

### Langkah 6: Pindah ke onPressed()
Ganti menjadi kode seperti berikut.
~~~Dart
getNumber().then((value) {
  setState(() {
    result = value.toString();
  });
}).catchError((e) {
  result = 'An error occurred';
});
~~~
### Soal 6
Jelaskan maksud perbedaan kode langkah 2 dengan langkah 5-6 tersebut!
pada Langkah 2 completer dibuat dan kemudian diselesaikan selalu dengan completer.complete(42) sehingga Future selalu berhasil dan pemanggil (then) menerima nilai 42; sedangkan pada Langkah 5–6 calculate() dibungkus try/catch dan jika terjadi error dipanggil completer.completeError(...), lalu pemanggil menggunakan getNumber().then(...).catchError(...)
![img](/W11/img/Soal6.gif)

## Praktikum 4: Memanggil Future secara paralel

Ketika Anda membutuhkan untuk menjalankan banyak Future secara bersamaan, ada sebuah class yang dapat Anda gunakan yaitu: FutureGroup.

FutureGroup tersedia di package async, yang mana itu harus diimpor ke file dart Anda, seperti berikut.
import 'package:async/async.dart';


### Langkah 1: Buka file main.dart

Tambahkan method ini ke dalam class _FuturePageState
~~~Dart
void returnFG() {
FutureGroup<int> futureGroup = FutureGroup<int>();
futureGroup.add(returnOneAsync());
futureGroup.add(returnTwoAsync());
futureGroup.add(return ThreeAsync());
futureGroup.close();
futureGroup.future.then((List <int> value) {
int total = 0;
for (var element in value) {
total += element;
}
setState(() {
result = total.toString();
});
});
}
~~~

### Langkah 2: Edit onPressed()
Anda bisa hapus atau comment kode sebelumnya, kemudian panggil method dari langkah 1 tersebut.
~~~Dart
onPressed: () {
returnFG();
}
~~~

### Langkah 3: Run
Anda akan melihat hasilnya dalam 3 detik berupa angka 6 lebih cepat dibandingkan praktikum sebelumnya menunggu sampai 9 detik.

### Soal 7
Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W11: Soal 7".

![img](/W11/img/Soal7.gif)

### Langkah 4: Ganti variabel futureGroup
Anda dapat menggunakan FutureGroup dengan Future.wait seperti kode berikut.
~~~Dart
final futures = Future.wait<int>([
  returnOneAsync(),
  returnTwoAsync(),
  returnThreeAsync(),
]);
~~~ 

### Soal 8
Jelaskan maksud perbedaan kode langkah 1 dan 4!

keduanya menjalankan beberapa Future secara paralel dan mengembalikan hasil ketika semua selesai, tetapi cara dan tujuan penggunaannya berbeda — FutureGroup (dari package:async) dirancang untuk kasus di mana Anda ingin menambah Future secara dinamis dari berbagai tempat lalu menutup group ketika sudah tidak ada lagi (berguna untuk pengumpulan hasil bertahap), sedangkan Future.wait (core Dart) menerima daftar Future yang sudah diketahui sebelumnya dan lebih sederhana/langsung dipakai tanpa dependensi eksternal. Secara performa keduanya sama (semua Future berjalan paralel), namun Future.wait lebih ringan dan biasanya dipakai kecuali Anda perlu kemampuan “add/close” atau pengelolaan yang lebih fleksibel dari FutureGroup.