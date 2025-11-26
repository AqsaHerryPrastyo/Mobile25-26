

## Praktikum 1: Konversi Dart model ke JSON


### Langkah 2: Buka file main.dart
Ketiklah kode seperti berikut ini.
~~~dart
import 'package:flutter/material.dart';
void main() {
}
runApp(const MyApp());
class MyApp extends StatelessWidget {
const MyApp({super.key});
// This widget is the root of your application.
@override
Widget build(BuildContext context) {
return MaterialApp(
title: 'Flutter JSON Demo',
theme:
ThemeData(
primarySwatch: Colors.blue,
),
home: const MyHomePage(),
);
}
}
class MyHomePage extends Statefulwidget {
}
const MyHomePage({super.key});
@override
State<MyHomePage> createState() => _MyHomePageState();
class MyHomePageState extends State<MyHomePage> {
@override
Widget build(BuildContext context) {
return Scaffold(
~~~

### Soal 1
Tambahkan nama panggilan Anda pada title app sebagai identitas hasil pekerjaan Anda.
Gantilah warna tema aplikasi sesuai kesukaan Anda.
Lakukan commit hasil jawaban Soal 1 dengan pesan "W13: Jawaban Soal 1"

### Langkah 3: Buat folder baru assets
Buat folder baru assets di root project Anda

### Langkah 4: Buat file baru pizzalist.json
Letakkan file ini di dalam folder assets, lalu salin data JSON berikut ke file tersebut.
~~~Dart
[ 
    { 
      "id": 1, 
      "pizzaName": "Margherita", 
      "description": "Pizza with tomato, fresh mozzarella and basil",
      "price": 8.75, 
      "imageUrl": "images/margherita.png" 
    }, 
    { 
      "id": 2, 
      "pizzaName": "Marinara", 
      "description": "Pizza with tomato, garlic and oregano",
      "price": 7.50, 
      "imageUrl": "images/marinara.png"  
    }, 
    { 
      "id": 3, 
      "pizzaName": "Napoli", 
      "description": "Pizza with tomato, garlic and anchovies",
      "price": 9.50, 
      "imageUrl": "images/marinara.png"  
    }, 
    { 
      "id": 4, 
      "pizzaName": "Carciofi", 
      "description": "Pizza with tomato, fresh mozzarella and artichokes",
      "price": 8.80, 
      "imageUrl": "images/marinara.png"  
    }, 
    { 
      "id": 5, 
      "pizzaName": "Bufala", 
      "description": "Pizza with tomato, buffalo mozzarella and basil",
      "price": 12.50, 
      "imageUrl": "images/marinara.png"  
    }
]
~~~

Jika Anda ingin menggunakan data JSON yang lain, Anda dapat mengakses salah satu dari daftar API di tautan ini: https://github.com/public-apis/public-apis

### Langkah 5: Edit pubspec.yaml
Tambahkan referensi folder assets ke file pubspec.yaml seperti berikut ini.
assets:
" - assets/

### Langkah 6: Edit maint.dart
Buatlah variabel seperti berikut ini class _MyHomePageState.
String pizzastring = '';

### Langkah 7: Tetap di main.dart
Untuk membaca isi dari file pizzalist.json di dalam class _MyHomePageState, tambahkan method readJsonFile seperti kode berikut untuk membaca file json.
~~~dart
Future readJsonfile() async {l
String myString = await DefaultAssetBundle.of(context)
•loadString(' assets/pizzalist.json');
setstate(() {
pizzastring = myString;
}) ;
}
~~~

### Langkah 8: Panggil method readJsonFile
Panggil method readJsonFile di initState
~~~dart
coverride
void initState() { super. initState() ;
readJsonFile();}
~~~

### Langkah 9: Tampilkan hasil JSON
Kemudian tampilkan hasil JSON di body scaffold.
body: Text (pizzaString),

### Langkah 10: Run
Jika kode sudah benar

### Soal 2
Masukkan hasil capture layar ke laporan praktikum Anda.
Lakukan commit hasil jawaban Soal 2 dengan pesan "W13: Jawaban Soal 2"