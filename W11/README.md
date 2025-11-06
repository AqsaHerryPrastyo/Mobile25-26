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


