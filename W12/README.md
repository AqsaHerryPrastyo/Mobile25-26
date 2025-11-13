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
~~~

### Soal 1
Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.
Gantilah warna tema aplikasi sesuai kesukaan Anda.
Lakukan commit hasil jawaban Soal 1 dengan pesan "W12: Jawaban Soal 1"