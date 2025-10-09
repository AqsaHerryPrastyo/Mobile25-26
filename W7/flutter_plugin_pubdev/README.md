## Praktikum Menerapkan Plugin di Project Flutter

### Langkah 1: Buat Project Baru
Buatlah sebuah project flutter baru dengan nama flutter_plugin_pubdev. Lalu jadikan repository di GitHub Anda dengan nama flutter_plugin_pubdev.

### Langkah 2: Menambahkan Plugin
Tambahkan plugin auto_size_text menggunakan perintah berikut di terminal
~~~Dart
flutter pub add auto_size_text
~~~
Jika berhasil, maka akan tampil nama plugin beserta versinya di file pubspec.yaml pada bagian dependencies.

### Langkah 3: Buat file red_text_widget.dart
Buat file baru bernama red_text_widget.dart di dalam folder lib lalu isi kode seperti berikut.
~~~Dart
import 'package:flutter/material.dart';

class RedTextWidget extends StatelessWidget {
  const RedTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
~~~

### Langkah 4: Tambah Widget AutoSizeText
Masih di file red_text_widget.dart, untuk menggunakan plugin auto_size_text, ubahlah kode return Container() menjadi seperti berikut.

~~~Dart
return AutoSizeText(
      text,
      style: const TextStyle(color: Colors.red, fontSize: 14),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
);
~~~

Setelah Anda menambahkan kode di atas, Anda akan mendapatkan info error. Mengapa demikian? Jelaskan dalam laporan praktikum Anda!

#### Jawaban
iya mendapatkan pesan error dikarenakan variable text belum didefinisikan
saya perbaiki dengan menambahkan 'text' sebagai final String text didalam class kemudian
menambahakn 'required this.text' di constructor

### Langkah 5: Buat Variabel text dan parameter di constructor
Tambahkan variabel text dan parameter di constructor seperti berikut.
~~~Dart
final String text;

const RedTextWidget({Key? key, required this.text}) : super(key: key);
~~~


### Langkah 6: Tambahkan widget di main.dart
Buka file main.dart lalu tambahkan di dalam children: pada class _MyHomePageState

~~~Dart

Container(
   color: Colors.yellowAccent,
   width: 50,
   child: const RedTextWidget(
             text: 'You have pushed the button this many times:',
          ),
),
Container(
    color: Colors.greenAccent,
    width: 100,
    child: const Text(
           'You have pushed the button this many times:',
          ),
),
~~~

>Hasil run
![image](/W7/flutter_plugin_pubdev/image/Prak.png)


## Tugas Praktikum

### 1. Selesaikan Praktikum tersebut, lalu dokumentasikan dan push ke repository Anda berupa screenshot hasil pekerjaan beserta penjelasannya di file README.md!
### 2. Jelaskan maksud dari langkah 2 pada praktikum tersebut!
Plugin auto_size_text adalah package yang menyediakan widget AutoSizeText yang secara otomatis menyesuaikan ukuran font agar teks dapat muat dalam ruang yang tersedia. Fitur utamanya:

- Menyesuaikan ukuran font secara otomatis
- Mendukung batasan maksimum baris teks
- Mengatur overflow text
- Memberikan kontrol yang lebih baik terhadap tampilan teks


### 3. Jelaskan maksud dari langkah 5 pada praktikum tersebut!
Kode final String text; dan const RedTextWidget({Key? key, required this.text}) : super(key: key); berfungsi untuk membuat variabel instance dan constructor yang memungkinkan widget menerima data dari luar. Variabel final String text mendeklarasikan sebuah variabel immutable bertipe String yang akan menyimpan teks yang akan ditampilkan oleh widget. 


### 4. Pada langkah 6 terdapat dua widget yang ditambahkan, jelaskan fungsi dan perbedaannya!

Fungsi dan Perbedaan:
Fungsi Utama: Kedua widget berfungsi untuk menampilkan teks yang sama yaitu "You have pushed the button this many times:", namun dengan implementasi dan tampilan yang berbeda.

Perbedaan Detail:

1. Jenis Widget Text:
Widget 1: Menggunakan RedTextWidget (custom widget yang menggunakan plugin AutoSizeText)
Widget 2: Menggunakan Text (widget bawaan Flutter)

2. Warna Background:
Widget 1: Background kuning (Colors.yellowAccent)
Widget 2: Background hijau (Colors.greenAccent)

3. Lebar Container:
Widget 1: Lebar 50 pixel
Widget 2: Lebar 100 pixel

4. Perilaku Text:
Widget 1: Text akan menyesuaikan ukuran font secara otomatis agar muat dalam container yang sempit (50px) karena menggunakan AutoSizeText dengan maxLines: 2 dan overflow: TextOverflow.ellipsis
Widget 2: Text menggunakan ukuran font default dan mungkin akan terpotong atau overflow jika tidak muat dalam container

5. Styling:
Widget 1: Text berwarna merah dengan fontSize 14 (sesuai konfigurasi di RedTextWidget)
Widget 2: Text menggunakan styling default tema aplikasi


Tujuan Perbandingan: Kedua widget ini sengaja ditambahkan untuk menunjukkan perbedaan perilaku antara widget Text biasa dengan widget AutoSizeText yang dapat menyesuaikan ukuran font secara otomatis, terutama terlihat jelas pada container dengan lebar yang berbeda (50px vs 100px).



### 5. Jelaskan maksud dari tiap parameter yang ada di dalam plugin auto_size_text berdasarkan tautan pada dokumentasi ini !

#### Parameter-parameter Plugin auto_size_text

Berdasarkan dokumentasi resmi dari https://pub.dev/documentation/auto_size_text/latest/, berikut adalah penjelasan lengkap tentang parameter-parameter yang tersedia dalam plugin auto_size_text:

#### Parameter Utama AutoSizeText:

1. **key** - Controls how one widget replaces another widget in the tree (sama seperti widget Text biasa)

2. **textKey** - Sets the key for the resulting Text widget

3. **style** - If non-null, the style to use for this text (sama seperti TextStyle pada widget Text)

4. **minFontSize** - Ukuran font minimum yang diizinkan saat auto-sizing text. Default value adalah 12. Jika teks masih tidak muat, akan ditangani sesuai dengan parameter overflow. Parameter ini diabaikan jika presetFontSizes diset.

5. **maxFontSize** - Ukuran font maksimum yang diizinkan saat auto-sizing text. Berguna jika TextStyle mewarisi font size dan Anda ingin membatasinya. Parameter ini diabaikan jika presetFontSizes diset.

6. **stepGranularity** - Langkah penurunan ukuran font setiap kali AutoSizeText mencoba menyesuaikan ukuran. Biasanya nilai ini tidak boleh di bawah 1 untuk performa terbaik. Default value adalah 1.

7. **presetFontSizes** - List ukuran font yang telah ditentukan sebelumnya. Jika parameter ini diset, maka minFontSize, maxFontSize, dan stepGranularity akan diabaikan. Font sizes harus dalam urutan menurun (descending order).

8. **group** - Menyinkronkan ukuran font dari multiple AutoSizeText. Semua AutoSizeText dalam grup yang sama akan memiliki ukuran yang sama, disesuaikan dengan anggota grup yang memiliki ukuran font efektif terkecil.

9. **textAlign** - How the text should be aligned horizontally (sama seperti widget Text)

10. **textDirection** - The directionality of the text (sama seperti widget Text)

11. **locale** - Used to select a font when the same Unicode character can be rendered differently (sama seperti widget Text)

12. **softWrap** - Whether the text should break at soft line breaks (sama seperti widget Text)

13. **wrapWords** - Whether words which don't fit in one line should be wrapped. Default adalah true agar berperilaku seperti Text widget.

14. **overflow** - How visual overflow should be handled (sama seperti widget Text)

15. **overflowReplacement** - Widget yang ditampilkan sebagai pengganti jika teks overflow dan tidak muat dalam bounds. Berguna untuk mencegah teks menjadi terlalu kecil untuk dibaca.

16. **textScaleFactor** - The number of font pixels for each logical pixel. Juga mempengaruhi minFontSize, maxFontSize dan presetFontSizes (sama seperti widget Text)

17. **maxLines** - Jumlah maksimum baris untuk teks. Jika tidak dispesifikasi, AutoSizeText hanya menyesuaikan teks berdasarkan lebar dan tinggi yang tersedia.

18. **semanticsLabel** - An alternative semantics label for this text (sama seperti widget Text)

#### Contoh Penggunaan Parameter:

```dart
AutoSizeText(
  'A really long String that needs to be resized',
  style: TextStyle(fontSize: 30),
  minFontSize: 18,
  maxFontSize: 25,
  stepGranularity: 2,
  maxLines: 2,
  overflow: TextOverflow.ellipsis,
  textAlign: TextAlign.center,
  wrapWords: true,
)
```

#### Parameter untuk AutoSizeText.rich():

AutoSizeText.rich() memiliki parameter yang sama, namun menggunakan TextSpan sebagai input untuk mendukung Rich Text dengan berbagai style dalam satu widget.

**Catatan Penting:**
- Parameter yang ditandai dengan * berperilaku sama seperti pada widget Text
- AutoSizeText membutuhkan bounded constraints untuk dapat meresize teks
- Jika menggunakan presetFontSizes, pastikan urutannya descending (dari besar ke kecil)

### 6. Kumpulkan laporan praktikum Anda berupa link repository GitHub kepada dosen!