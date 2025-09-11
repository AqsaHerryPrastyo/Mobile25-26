# Menjawab Soal no 2 - 4

 ## Soal no 2
 - Dart adalah Bahasa Utama Flutter
Flutter adalah framework UI yang menggunakan Dart sebagai bahasa pemrogramannya. Semua logika aplikasi, seperti pengelolaan state, interaksi pengguna, dan komunikasi dengan backend, ditulis dalam Dart.
- Performa Aplikasi
Dart dirancang untuk performa tinggi dengan fitur seperti Ahead-of-Time (AOT) compilation, yang menghasilkan kode native untuk aplikasi Flutter. Memahami cara Dart mengelola memori, garbage collection, atau optimasi kode akan membantu Anda menulis aplikasi yang lebih cepat dan efisien.<br>

## Soal no 3
**Konsep Dasar Dart**<br>
- Bahasa modern & fleksibel: mendukung lintas platform (web, mobile, desktop).<br>
- Fokus utama saat ini: mobile development (Flutter).<br>
- Tujuan awal: menjadi penerus JavaScript dengan performa lebih baik dan stabil.
<br><br>

**Fitur Utama Dart**<br>
1. Productive tooling → IDE plugin, analisis kode, ekosistem paket besar.<br>
2. Garbage collection → otomatis mengelola memori objek yang tidak terpakai.<br>
3. Type annotations opsional → tetap type-safe dengan type inference.<br>
4. Statically typed → mendeteksi bug saat kompilasi.<br>
5. Portability → bisa dikompilasi ke JavaScript (untuk web) atau native ARM/x86 (untuk mobile).<br><br>

**Eksekusi Kode Dart**<br>
- Dart VM → mendukung JIT (Just-In-Time), cocok untuk debugging & hot reload.<br>
- dart2js → kompilasi ke JavaScript agar dapat berjalan di browser.<br>
- AOT (Ahead-Of-Time) → kompilasi native untuk performa tinggi (rilis aplikasi).<br><br>

**Hot Reload**
- Fitur terkenal Flutter, berbasis JIT compiler.<br>
- Mempercepat pengembangan dengan feedback instan saat kode diubah.<br><br>

**Paradigma Pemrograman**<br>
- Object-Oriented (OO) → mendukung encapsulation, inheritance, abstraction, composition, polymorphism.<br>
- Semua data adalah objek (tidak ada tipe primitif seperti di Java).<br><br>

**Operator di Dart**<br>
1. Aritmatika: + - * / ~/ % (termasuk shortcut += -= *= /= ~/=).<br>
2. Increment/Decrement: ++var, var++ dan --var, var--.<br>
3. Equality & Relational: == != > < >= <=.<br>
- == membandingkan isi, bukan referensi memori.<br>
- Tidak ada === seperti di JavaScript (karena sudah type-safe).<br>
4. Logical: ! (NOT), || (OR), && (AND).<br><br>

**Evolusi Dart**<br>
- 2011 → pertama kali diluncurkan.
- 2013 → versi stabil.
- 2018 (Dart 2.0) → perubahan besar, fokus ke Flutter.<br><br>

# Soal no 4
**Null Safety**<br>
- Pengertian: Null safety memastikan variabel tidak bisa bernilai null, kecuali secara eksplisit diizinkan dengan tanda ?.
- Tujuan: Menghindari error null reference (sering disebut null pointer exception).
- Aturan:
Variabel biasa wajib diinisialisasi sebelum digunakan.
Jika ingin bisa menyimpan null, gunakan tipe dengan tanda ?.<br>

**Contoh Null Safety**<br>
void main() {<br>
  // Variabel wajib diisi<br>
  String name = "Herry";  
  print(name);

  // Variabel boleh null karena ada ?<br>
  String? nickname;<br>
  print(nickname); // Output: null

  // Mengakses nullable harus dicek atau menggunakan operator<br>
  if (nickname != null) {<br>
    print(nickname.length);
  }
}

**Late Variable**<br>
- Pengertian: late digunakan saat variabel tidak langsung diinisialisasi, tetapi pasti akan diinisialisasi sebelum dipakai.
- Tujuan: Menunda inisialisasi variabel, misalnya jika nilainya berat dihitung atau bergantung pada kondisi tertentu.
- Ciri khas: Jika variabel late dipakai sebelum diinisialisasi, akan muncul error runtime.

**contoh Late Variable**<br>
void main() {<br>
  // Variabel late tanpa nilai awal<br>
  late String description;

  // Inisialisasi nanti<br>
  description = "Belajar Flutter dengan Dart";<br>
  print(description);

  // Contoh penggunaan late dengan lazy initialization<br>
  late int bigCalculation = expensiveOperation();<br>
  print(bigCalculation);
}

int expensiveOperation() {<br>
  print("Melakukan perhitungan berat...");<br>
  return 999;
}

**Perbedaan Utama**<br>
| Fitur              | Null Safety                              | Late Variable                                      |
|--------------------|------------------------------------------|--------------------------------------------------|
| **Tujuan**         | Mencegah error karena nilai `null`.      | Menunda inisialisasi variabel.                   |
| **Sintaks**        | `T? varName;`                           | `late T varName;`                                |
| **Waktu inisialisasi** | Bisa null sejak awal.                   | Harus diinisialisasi sebelum dipakai.            |
| **Error jika salah** | Error saat mengakses `null` tanpa cek. | Error runtime jika dipakai sebelum diinisialisasi. |





