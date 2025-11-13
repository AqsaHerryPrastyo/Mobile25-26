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

![img](/W11/img/Soal4.gif)