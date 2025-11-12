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

## Praktikum 5: Menangani Respon Error pada Async Code

Ada beberapa teknik untuk melakukan handle error pada code async. Pada praktikum ini Anda akan menggunakan 2 cara, yaitu then() callback dan pola async/await.

Setelah Anda menyelesaikan praktikum 4, Anda dapat melanjutkan praktikum 5 ini. Selesaikan langkah-langkah praktikum berikut ini menggunakan editor Visual Studio Code (VS Code) atau Android Studio atau code editor lain kesukaan Anda. Jawablah di laporan praktikum Anda pada setiap soal yang ada di beberapa langkah praktikum ini.

### Langkah 1: Buka file main.dart
Tambahkan method ini ke dalam class _FuturePageState

~~~Dart
Future returnError() async {
await Future.delayed(const Duration(seconds: 2));
throw Exception('Something terrible happened!');
}
~~~

### Langkah 2: ElevatedButton
Ganti dengan kode berikut
~~~Dart
returnError()
.then((value) {
setState(() {
result = 'Success';
});
}).catchError ((onError) {
setState(() {
result = onError.toString();
});
}).whenComplete(() => print('Complete'));
~~~

### Langkah 3: Run
Lakukan run dan klik tombol GO! maka akan menghasilkan seperti gambar berikut.

### Soal 9
Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W11: Soal 9".
![img](/W11/img/Soal9.png)

### Langkah 4: Tambah method handleError()
Tambahkan kode ini di dalam class _FutureStatePage

~~~Dart
Future handleError() async {
try {
await returnError();
}
catch (error) {
setState(() {
result = error.toString();
});
}
finally {
print('Complete');
}
}
~~~

### Soal 10
Panggil method handleError() tersebut di ElevatedButton, lalu run. Apa hasilnya? Jelaskan perbedaan kode langkah 1 dan 4!

### Jawaban Soal 10

- Hasil setelah memanggil `handleError()` dari tombol ElevatedButton:
  - Setelah menekan tombol GO, `handleError()` akan memanggil `returnError()` dengan `await`. Karena `returnError()` melempar Exception, kode langsung masuk ke blok `catch`.
  - Di blok `catch`, variabel `result` di-set menjadi pesan error yang sudah dibersihkan (mis. "Something terrible happened!") sehingga UI menampilkan pesan ini.
  - Blok `finally` selalu dieksekusi sehingga konsol akan menampilkan "Complete".

- Perbedaan antara Langkah 1 (menggunakan `.then/.catchError/.whenComplete`) dan Langkah 4 (menggunakan `async/await` dengan `try/catch/finally`):
  - Sintaks dan gaya:
    - `.then/.catchError` menggunakan chaining callback; `async/await` menggunakan struktur try/catch yang mirip kode sinkron.
  - Pembacaan & pemeliharaan:
    - `async/await` biasanya lebih mudah dibaca dan di-debug pada alur yang kompleks.
  - Kontrol alur:
    - Dengan `.then`, handler error dipasang secara eksplisit di chain; dengan `try/catch`, error ditangkap langsung pada tempat pemanggilan `await`.
  - Hasil runtime:
    - Kedua pendekatan setara fungsional: keduanya menangani hasil dan error Future. Perbedaan utama hanya pada gaya penulisan dan kenyamanan pembacaan.

## Praktikum 6: Menggunakan Future dengan StatefulWidget

Seperti yang Anda telah pelajari, Stateless widget tidak dapat menyimpan informasi (state), StatefulWidget dapat mengelola variabel dan properti dengan method setState(), yang kemudian dapat ditampilkan pada UI. State adalah informasi yang dapat berubah selama life cycle widget itu berlangsung.

Ada 4 method utama dalam life cycle StatefullWidget:

initState(): dipanggil sekali ketika state dibangun. Bisa dikatakan ini juga sebagai konstruktor class.
build(): dipanggil setiap kali ada perubahan state atau UI. Method ini melakukan destroy UI dan membangun ulang dari nol.
deactive() dan dispose(): digunakan untuk menghapus widget dari tree, pada beberapa kasus dimanfaatkan untuk menutup koneksi ke database atau menyimpan data sebelum berpindah screen.
Setelah Anda menyelesaikan praktikum 5, Anda dapat melanjutkan praktikum 6 ini. Selesaikan langkah-langkah praktikum berikut ini menggunakan editor Visual Studio Code (VS Code) atau Android Studio atau code editor lain kesukaan Anda. Jawablah di laporan praktikum Anda pada setiap soal yang ada di beberapa langkah praktikum ini.

### Langkah 1: install plugin geolocator
Tambahkan plugin geolocator dengan mengetik perintah berikut di terminal.
~~~Dart
flutter pub add geolocator
~~~
### Langkah 2: Tambah permission GPS
Jika Anda menargetkan untuk platform Android, maka tambahkan baris kode berikut di file android/app/src/main/androidmanifest.xml
~~~Dart
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION"/>
<uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION"/>
~~~

### Langkah 3: Buat file geolocation.dart
Tambahkan file baru ini di folder lib project Anda.

### Langkah 4: Buat StatefulWidget
Buat class LocationScreen di dalam file geolocation.dart

### Langkah 5: Isi kode geolocation.dart
~~~Dart
import 'package:flutter/material.dart';
import 'package: geolocator/geolocator.dart';
class LocationScreen extends StatefulWidget {
const LocationScreen({super.key});
}
@override
State<LocationScreen> createState() => _LocationScreenState();
class_LocationScreenState extends State <LocationScreen> {
String myPosition = '';
@override
void initState() {
super.initState();
getPosition().then((Position myPos) {
myPosition =
'Latitude: ${myPos.latitude.toString()) Longitude:
{myPos.longitude.toString()}';
}
setState(() {
myPosition = myPosition;
});
});
@override
Widget build (BuildContext context) {
}
return Scaffold(
appBar: AppBar(title: const Text('Current Location')),
body: Center (child: Text (myPosition)),
);
Future<Position> getPosition() async {
await Geolocator.requestPermission();
await Geolocator.isLocationServiceEnabled();
Position? position =
await Geolocator. getCurrentPosition();
return position;
}}
~~~

### Soal 11
Tambahkan nama panggilan Anda pada tiap properti title sebagai identitas pekerjaan Anda.

### Jawaban Soal 11

- Pada tugas ini saya menambahkan nama panggilan "Aqsa" pada properti `title` di beberapa tempat (contoh: `Future Demo - Aqsa`, `Back from the Future - Aqsa`, dan `Current Location - Aqsa`) untuk menandai hasil pekerjaan.

- Setelah menambah dependensi `geolocator` di `pubspec.yaml`, jalankan perintah berikut sebelum build/run agar paket ter-install:

```bash
flutter pub get
```
### Langkah 6: Edit main.dart
Panggil screen baru tersebut di file main Anda seperti berikut.
~~~Dart
home: LocationScreen(),
~~~

### Langkah 7: Run
Run project Anda di device atau emulator (bukan browser), maka akan tampil seperti berikut ini.
![img](/W11/img/Soal11.png)

### Langkah 8: Tambahkan animasi loading
Tambahkan widget loading seperti kode berikut. Lalu hot restart, perhatikan perubahannya.
~~~Dart
@override
Widget build (BuildContext context) {
final myWidget = myPosition ==
? const Circular ProgressIndicator()
: const Text(myPosition);;
return Scaffold(
appBar: AppBar(title: Text('Current Location')),
body: Center(child:myWidget),
);
}
~~~

### Soal 12
Jika Anda tidak melihat animasi loading tampil, kemungkinan itu berjalan sangat cepat. Tambahkan delay pada method getPosition() dengan kode await Future.delayed(const Duration(seconds: 3));
Apakah Anda mendapatkan koordinat GPS ketika run di browser? Mengapa demikian?
Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W11: Soal 12".

### Jawaban Soal 12

- Setelah menambahkan `await Future.delayed(const Duration(seconds: 3));` pada `getPosition()`, loading indicator akan terlihat karena kita memaksa penundaan selama 3 detik sebelum pengambilan posisi dimulai.
- Mengenai apakah Anda mendapatkan koordinat GPS saat menjalankan di browser:
  - Umumnya TIDAK. Paket `geolocator` berfungsi pada platform native (Android, iOS, macOS, Windows) dan tidak menggunakan API browser langsung. Untuk Flutter Web, Anda perlu paket yang mendukung web (mis. `geolocator_web`) or menggunakan JavaScript interop to call the browser Geolocation API. Selain itu, running in a desktop browser on a laptop/PC may not provide precise GPS coordinates (the browser may use IP-based location or ask user permission and return coarse location).
  - Singkatnya: `geolocator` may not return GPS coordinates on `flutter run -d chrome` or similar; use a real device (Android/iOS) or a web implementation that uses the browser Geolocation API.

  [img](/W11/img/Soal12.png)

## Praktikum 7: Manajemen Future dengan FutureBuilder

### Langkah 1: Modifikasi method getPosition()
Buka file geolocation.dart kemudian ganti isi method dengan kode ini.
~~~Dart
Future<Position> getPosition() async {
await Geolocator.isLocationServiceEnabled();
await Future.delayed(const Duration(seconds: 3));
Position position = await Geolocator. getCurrentPosition ();
return position; }
~~~

### Langkah 2: Tambah variabel
Tambah variabel ini di class _LocationScreenState
~~~Dart
Future<Position>? position;
~~~

### Langkah 3: Tambah initState()
Tambah method ini dan set variabel position
~~~Dart
@override
void initState() {
super.initState();
position = getPosition();
}
~~~

### Langkah 4: Edit method build()
Ketik kode berikut dan sesuaikan. Kode lama bisa Anda comment atau hapus.
~~~Dart
@override
Widget build(BuildContext context) {
return Scaffold(
appBar: AppBar (title: Text('Current Location')),
body: Center (child: FutureBuilder(
future: position,
builder: (BuildContext context, AsyncSnapshot<Position>
snapshot) {
if (snapshot.connectionState ==
ConnectionState.waiting) {
return const CircularProgress Indicator();
}
else if (snapshot.connectionState ==
ConnectionState.done) {
return Text(snapshot.data.toString());
}
else {
return const Text('');
}
},
),
));
}
~~~
### Soal 13
Apakah ada perbedaan UI dengan praktikum sebelumnya? Mengapa demikian?
Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W11: Soal 13".
### Jawaban Soal 13

- Apakah ada perbedaan UI dengan praktikum sebelumnya?
  - Secara visual untuk pengguna tidak banyak berubah: kedua pendekatan menampilkan indikator loading (CircularProgressIndicator) saat menunggu dan menampilkan koordinat (Text) saat Future selesai.
  - Perbedaan utama ada pada cara kerja dan pengelolaan state di dalam kode: pada implementasi lama Anda menangani callback dan memanggil `setState()` secara manual, sedangkan `FutureBuilder` membuat widget menjadi reaktif dan otomatis merespon perubahan status Future tanpa perlu memanggil `setState()` secara eksplisit.

### Langkah 5: Tambah handling error
Tambahkan kode berikut untuk menangani ketika terjadi error. Kemudian hot restart.
~~~Dart
else if (snapshot.connectionState == ConnectionState.done) {
  if (snapshot.hasError) {
     return Text('Something terrible happened!');
  }
  return Text(snapshot.data.toString());
}
~~~

### Soal 14
Apakah ada perbedaan UI dengan langkah sebelumnya? Mengapa demikian?
Capture hasil praktikum Anda berupa GIF dan lampirkan di README. Lalu lakukan commit dengan pesan "W11: Soal 14".
### Jawaban Soal 14

- Apakah ada perbedaan UI dengan langkah sebelumnya?
  - Ya — sekarang ketika terjadi error pada proses pengambilan posisi, UI menampilkan pesan error yang informatif (mis. "Something terrible happened!" atau teks error dari `snapshot.error`) alih-alih menampilkan teks kosong atau tidak merespon.

- Mengapa demikian?
  - Dengan menambahkan pengecekan `snapshot.hasError` di `FutureBuilder`, Anda mengekspresikan penanganan error secara eksplisit di layer UI. Ini memungkinkan aplikasi menampilkan state error secara deterministik dan ramah pengguna.
  - Sebelumnya, tanpa `hasError`, jika terjadi exception hasilnya bisa tidak ter-handle dengan baik (widget mungkin menampilkan kosong atau aplikasi dapat crash tergantung bagaimana error ditangani). Dengan `hasError` Anda dapat:
    - Menampilkan pesan yang jelas kepada pengguna.
    - Menyediakan fallback UI (mis. tombol coba lagi) atau instruksi selanjutnya.
    - Menghindari menampilkan data kosong atau raw exception yang sulit dibaca.

![img](/W11/img/Soal11.png)




