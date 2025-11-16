| Nama      | NIM      | Kelas      | Mata Kuliah | Semester |
|-----------|----------|------------|-------------|----------|
| Aqsa Herry P | 2341720153 | TI-3H | PEMROGRAMAN MOBILE | 5 |

# Lanjutan State Management dengan Streams

## Praktikum 1: Dart Streams

### Langkah 1: Buat Project Baru
Buatlah sebuah project flutter baru dengan nama stream_nama (beri nama panggilan Anda) di folder week-12/src/ repository GitHub Anda.

### Langkah 2: Buka file main.dart
Ketiklah kode seperti berikut ini.

~~~Dart
import 'package:flutter/material.dart';
void main() {
runApp(const MyApp());
}
class MyApp extends StatelessWidget {
const MyApp({super.key});
@override
Widget build (BuildContext context) {
return MaterialApp(
title:
'Stream',
theme: ThemeData(
primarySwatch: Colors.deepPurple,
),
home: const StreamHomePage(),
);
}
}
class StreamHomePage extends StatefulWidget {
const StreamHomePage({super.key});
@override
State<StreamHomePage> createState() => _StreamHomePageState();
}

class StreamHomePageState extends State<StreamHomePage> {
@override
Widget build (BuildContext context) {
return Container();
}
}
~~~

### Soal 1
Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.
Gantilah warna tema aplikasi sesuai kesukaan Anda.
Lakukan commit hasil jawaban Soal 1 dengan pesan "W12: Jawaban Soal 1"

**Soal 1**: Jawaban
- **Title**: `Stream - Herry` (ditambahkan nama panggilan Herry pada `MaterialApp.title`).
- **Theme**: menggunakan seed color `Colors.teal` pada `ThemeData`.
- **File**: `stream_herry/lib/main.dart`.
- **Commit**: `W12: Jawaban Soal 1`.

### Langkah 3: Buat file baru stream.dart
Buat file baru di folder lib project Anda. Lalu isi dengan kode berikut.
~~~Dart
import package: flutter/material.dart';
class ColorStream {}
~~~

### Langkah 4: Tambah variabel colors
Tambahkan variabel di dalam class ColorStream seperti berikut.
~~~Dart
final List<Color> colors = [
Colors. blueGrey,
Colors. amber,
Colors. deepPurple,
Colors.lightBlue,
Colors.teal];
~~~

### Soal 2
Tambahkan 5 warna lainnya sesuai keinginan Anda pada variabel colors tersebut.
Lakukan commit hasil jawaban Soal 2 dengan pesan "W12: Jawaban Soal 2"

**Soal 2**: Jawaban
- Menambahkan 5 warna tambahan di variabel `colors` pada class `ColorStream`.
- Warna yang ditambahkan: `Colors.green`, `Colors.orange`, `Colors.pink`, `Colors.lime`, `Colors.indigo`.
- File: `stream_herry/lib/stream.dart`.
- Commit: `W12: Jawaban Soal 2`.

### Langkah 5: Tambah method getColors()
Di dalam class ColorStream ketik method seperti kode berikut. Perhatikan tanda bintang di akhir keyword async* (ini digunakan untuk melakukan Stream data)
~~~Dart
Stream<Color> getColors) async* {}
~~~

### Langkah 6: Tambah perintah yield*
Tambahkan kode berikut ini.
~~~Dart
yield* Stream.periodic(
  const Duration(seconds: 1), (int t) {
    int index = t % colors.length;
    return colors[index];
});
~~~

### Soal 3
Jelaskan fungsi keyword yield* pada kode tersebut!
Apa maksud isi perintah kode tersebut?
Lakukan commit hasil jawaban Soal 3 dengan pesan "W12: Jawaban Soal 3"

**Soal 3**: Jawaban
- Method yang ditambahkan di `ColorStream`:

- **Fungsi `yield*`:**
  - `yield*` pada `async*` generator digunakan untuk meneruskan (delegate) semua event dari Stream lain ke pemanggil generator saat ini. Artinya, setiap nilai yang dipancarkan Stream yang didelegasikan akan langsung dipancarkan kembali oleh `getColors()`.

- **Maksud isi perintah kode:**
  - `Stream.periodic(const Duration(seconds: 1), ...)` membuat sebuah Stream yang mengeluarkan sebuah nilai setiap 1 detik.
  - Fungsi callback menerima counter `t` (0, 1, 2, ...). `index = t % colors.length` memastikan pemilihan warna berulang (siklik) dari daftar `colors`.
  - `yield* Stream.periodic(...)` berarti semua warna yang dihasilkan Stream.periodic akan diteruskan keluar oleh `getColors()`, sehingga listener `getColors()` menerima satu warna setiap detik secara bergantian.


### Langkah 7: Buka main.dart
Ketik kode impor file ini pada file main.dart
~~~Dart
import 'stream.dart';
~~~

Langkah 8: Tambah variabel
Ketik dua properti ini di dalam class _StreamHomePageState
~~~Dart
Color bgColor = Colors.blueGrey;
late ColorStream colorStream;
~~~

### Langkah 9: Tambah method changeColor()
Tetap di file main, Ketik kode seperti berikut
~~~Dart
void changeColor() async {
await for (var eventColor in colorStream.getColors()) {
setState(() {
bgColor = eventColor;
});
}
}
~~~

### Langkah 10: Lakukan override initState()
Ketika kode seperti berikut
~~~Dart
@override
void initState() {
super.initState();
colorStream = ColorStream();
changeColor();
}
~~~

### Langkah 11: Ubah isi Scaffold()
Sesuaikan kode seperti berikut.
~~~Dart
return Scaffold(
appBar:
AppBar(
title:
const Text('Stream"),
),
body:
Container(
decoration: BoxDecoration(color: bgColor),
));
}
~~~
### Langkah 12: Run
Lakukan running pada aplikasi Flutter Anda, maka akan terlihat berubah warna background setiap detik.

### Soal 4
Capture hasil praktikum Anda berupa GIF dan lampirkan di README.
Lakukan commit hasil jawaban Soal 4 dengan pesan "W12: Jawaban Soal 4"

![img](/W12/img/Soal4.gif)


### Langkah 13: Ganti isi method changeColor()
Anda boleh comment atau hapus kode sebelumnya, lalu ketika kode seperti berikut.
~~~Dart
colorStream.getColors().listen((eventColor) {
setState(() {
bgColor = eventColor;
});
});
~~~

### Soal 5
Jelaskan perbedaan menggunakan listen dan await for (langkah 9) !
Lakukan commit hasil jawaban Soal 5 dengan pesan "W12: Jawaban Soal 5"

**Soal 5**: Jawaban
- **Perbedaan utama:**
  - **`listen`**: mendaftarkan callback yang dipanggil setiap kali Stream mengeluarkan event. `listen` segera kembali (non-blocking) dan mengembalikan sebuah `StreamSubscription` yang bisa dipause, resume, atau dibatalkan (`cancel`). Cocok untuk event-driven handling dan jika Anda perlu kontrol manual pada subscription (pause/resume/cancel).
  - **`await for`**: menjalankan loop asynchronous yang menunggu setiap event secara berurutan sampai Stream selesai atau loop dihentikan. Kode setelah `await for` akan menunggu sampai loop selesai; tidak mengembalikan `StreamSubscription` langsung. `await for` lebih mudah untuk penanganan linear (sequential) dan error handling menggunakan try/catch di dalam fungsi `async`.

- **Perbedaan perilaku praktis:**
  - `listen` tidak menghentikan fungsi pemanggil — ia mendaftarkan callback dan fungsi pemanggil bisa terus berjalan. `await for` akan menunggu di tempat sampai stream selesai atau loop dihentikan.
  - Dengan `listen` Anda bisa menghentikan (cancel) langganan kapan saja via `subscription.cancel()`. Dengan `await for` Anda menghentikan loop dengan `break` atau keluar dari fungsi; untuk kontrol yang sama perlu mekanisme tambahan.

- **Kapan memakai yang mana:**
  - Gunakan `listen` bila Anda butuh kontrol lifecycle (pause/resume/cancel) atau ketika Anda ingin memproses event tanpa men-block eksekusi fungsi.
  - Gunakan `await for` bila Anda ingin menulis logika yang sederhana, sequential, dan ingin menunggu sampai Stream selesai atau berhenti berdasarkan kondisi internal.


## Praktikum 2: Stream controllers dan sinks

### Langkah 1: Buka file stream.dart
Lakukan impor dengan mengetik kode ini.
~~~Dart
import 'dart:async';
~~~

### Langkah 2: Tambah class NumberStream
Tetap di file stream.dart tambah class baru seperti berikut.
~~~Dart
class NumberStream {
}
~~~
### Langkah 3: Tambah StreamController
Di dalam class NumberStream buatlah variabel seperti berikut.
~~~Dart
final StreamController<int> controller = StreamController<int>();
~~~

### Langkah 4: Tambah method addNumberToSink
Tetap di class NumberStream buatlah method ini
~~~Dart
void addumberToSink(int newNumber){
controller.sink.add(newNumber);}
~~~ 

### Langkah 5: Tambah method close()
~~~Dart
close () {
controller.close();}
~~~
### Langkah 6: Buka main.dart
Ketik kode import seperti berikut
~~~Dart
import 'dart: async';
import 'dart: math';
~~~

### Langkah 7: Tambah variabel
Di dalam class _StreamHomePageState ketik variabel berikut
~~~Dart
int lastNumber = 0;
late StreamController numberStreamController;
late NumberStream numberStream;
~~~ 
### Langkah 8: Edit initState()
~~~Dart
@override
void initState() {
numberStream = NumberStream();
numberStreamController = numberStream.controller;
Stream stream = numberStreamController.stream;
stream.listen((event) {
setState(() {
lastNumber = event;
});
});
super.initState();
}
~~~
### Langkah 9: Edit dispose()
~~~Dart
coverride
void dispose () {
numberStreamController.close();
super. dispose();}
~~~
### Langkah 10: Tambah method addRandomNumber()
~~~Dart
void addRandomNumber() {
  Random random = Random();
  int myNum = random.nextInt(10);
  numberStream.addNumberToSink(myNum);
}
~~~
### Langkah 11: Ubah isi Scaffold()
Sesuaikan kode seperti berikut.
~~~Dart
body: SizedBox (
width: double.infinity,
child: Column (
mainAxisAlignment: MainAxisAlignment.spaceEvenly,
crossAxisAlignment: CrossAxisAlignment.center,
children:
[
Text(lastNumber.toString()),
ElevatedButton(
onPressed: () => addRandomNumber(),
child: Text('New Random Number'),
)
],
),
)
~~~
### Langkah 12: Run
Lakukan running pada aplikasi Flutter Anda, maka akan terlihat seperti gambar berikut.

### Soal 6
Jelaskan maksud kode langkah 8 dan 10 tersebut!
Capture hasil praktikum Anda berupa GIF dan lampirkan di README.
Lalu lakukan commit dengan pesan "W12: Jawaban Soal 6".

**Soal 6**: Jawaban
- **Langkah 8 (inisialisasi stream & listener):**
  - `numberStream = NumberStream();` membuat instance `NumberStream` yang menyimpan sebuah `StreamController<int>`; controller ini menjadi sumber event (angka) yang akan dipancarkan.
  - `numberStreamController = numberStream.controller;` mengambil referensi controller agar bisa mengakses `stream` dan/atau `sink` jika perlu.
  - `Stream stream = numberStreamController.stream;` mengambil `Stream<int>` dari controller; ini adalah aliran event yang dapat didengarkan oleh consumer.
  - `stream.listen((event) { setState(() { lastNumber = event; }); });` mendaftarkan callback yang dipanggil setiap kali ada event baru. Di sini callback memanggil `setState()` untuk menyimpan `event` ke `lastNumber` dan memicu rebuild UI sehingga angka terbaru tampil.
  - Efek praktis: saat controller menerima nilai melalui `controller.sink.add(value)`, listener akan dipanggil dan UI diperbarui.

- **Langkah 10 (producer: menambah angka acak ke sink):**
  - `Random random = Random();` membuat generator angka acak.
  - `int myNum = random.nextInt(10);` menghasilkan bilangan acak 0..9.
  - `numberStream.addNumberToSink(myNum);` memanggil method pada `NumberStream` yang melakukan `controller.sink.add(newNumber);` — menaruh `myNum` ke sink controller.
  - Efek praktis: menambahkan nilai ke sink menyebabkan controller meneruskan event ke stream, listener di Langkah 8 menerima event tersebut dan UI diperbarui.

![img](/W12/img/Soal6.gif)


### Langkah 13: Buka stream.dart
Tambahkan method berikut ini.
~~~Dart
addError() {
controller.sink.addError('error');
}
~~~

### Langkah 14: Buka main.dart
Tambahkan method onError di dalam class StreamHomePageState pada method listen di fungsi initState() seperti berikut ini.
~~~Dart
stream.listen((event) {
setState(() {
lastNumber = event;
});
}).onError((error) {
setState(() {
lastNumber = -1;
});
});
~~~

### Langkah 15: Edit method addRandomNumber()
Lakukan comment pada dua baris kode berikut, lalu ketik kode seperti berikut ini.
~~~Dart
void addRandomNumber() {
Random random = Random();
//int myNum = random.nextInt(10);
//numberStream.addNumberToSinh (myNum);
numberStream.addError();
}
~~~

### Soal 7
Jelaskan maksud kode langkah 13 sampai 15 tersebut!
Kembalikan kode seperti semula pada Langkah 15, comment addError() agar Anda dapat melanjutkan ke praktikum 3 berikutnya.
Lalu lakukan commit dengan pesan "W12: Jawaban Soal 7".

## Langkah 13 - 15 (penjelasan & instruksi)

**Langkah 13**: `addError()` di `NumberStream` — method ini memanggil `controller.sink.addError('error')` untuk memasukkan error ke aliran stream. Berguna untuk menguji penanganan error pada consumer.

**Langkah 14**: Menangani error di listener (`onError`) — di `main.dart` kita menambahkan `.onError((error) { setState(() { lastNumber = -1; }); });` pada `stream.listen(...)` sehingga ketika stream memancarkan error, UI menampilkan `-1` sebagai indikator error.

**Langkah 15**: Mengubah `addRandomNumber()` untuk memancarkan error pada pengujian. Untuk eksperimen, Anda dapat mengomentari pemanggilan `addNumberToSink()` dan memanggil `numberStream.addError()` sehingga setiap tekan tombol akan memicu error yang ditangani oleh `onError`.