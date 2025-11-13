import 'package:flutter/material.dart';

class ColorStream {
  final List<Color> colors = const [
    Colors.blueGrey,
    Colors.amber,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
    // five additional colors as requested in Soal 2
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.lime,
    Colors.indigo,
  ];

  // Langkah 5 & 6: method yang mengembalikan Stream<Color>
  Stream<Color> getColors() async* {
    yield* Stream.periodic(
      const Duration(seconds: 1), (int t) {
        int index = t % colors.length;
        return colors[index];
      },
    );
  }
}
