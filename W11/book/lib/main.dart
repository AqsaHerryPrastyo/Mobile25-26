import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Soal 1: tambahkan nama panggilan pada title (menggunakan "Aqsa")
      title: 'Future Demo - Aqsa',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: false,
      ),
      home: const FuturePage(),
    );
  }
}

class FuturePage extends StatefulWidget {
  const FuturePage({super.key});

  @override
  State<FuturePage> createState() => _FuturePageState();
}

class _FuturePageState extends State<FuturePage> {
  String result = '';

  // Langkah 4 (ditanyakan pada instruksi) - method untuk mengambil data dari Google Books
  Future<http.Response> getData() async {
    const authority = 'www.googleapis.com';
    // Soal 2: gunakan volume ID dari URL yang Anda berikan: xbA4gFJBZ_UC
    const path = '/books/v1/volumes/xbA4gFJBZ_UC';
    final url = Uri.https(authority, path);
    return http.get(url);
  }

  // Praktikum 3 - Completer example
  late Completer<int> completer;

  Future<int> getNumber() {
    completer = Completer<int>();
    calculate();
    return completer.future;
  }

  Future<void> calculate() async {
    await Future.delayed(const Duration(seconds: 5));
    completer.complete(42);
  }

  // Praktikum 2 - Langkah 1: tiga method async yang mengembalikan angka setelah delay
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

  // Praktikum 2 - Langkah 2: count() yang memanggil ketiga method di atas secara berurutan
  Future<void> count() async {
    int total = 0;
    total = await returnOneAsync();
    total += await returnTwoAsync();
    total += await returnThreeAsync();
    setState(() {
      result = total.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back from the Future - Aqsa'),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Spacer(),
            ElevatedButton(
              child: const Text('GO!'),
              onPressed: () {
                // Praktikum 3 - Langkah 3: gunakan Completer
                setState(() {
                  result = 'Getting number...';
                });
                getNumber().then((value) {
                  setState(() {
                    result = value.toString();
                  });
                });
              },
            ),
            const Spacer(),
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12.0),
                child: Text(result),
              ),
            ),
            const Spacer(),
            // Keep a continuously animating indicator as noted in instructions
            const CircularProgressIndicator(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
