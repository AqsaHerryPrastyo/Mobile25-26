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
                // show immediate feedback
                setState(() {
                  result = 'Loading...';
                });
                // use then/catchError as required by the exercise
                getData().then((value) {
                  // take only the first 450 characters to avoid huge output
                  result = value.body.toString().substring(0, 450);
                  setState(() {});
                }).catchError((_) {
                  // handle any error from the Future
                  result = 'An error occurred';
                  setState(() {});
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
