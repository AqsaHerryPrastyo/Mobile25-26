import 'dart:async';
import 'dart:math';

class NumberStream {
  Stream<int> getNumbers() async* {
    yield* Stream.periodic(const Duration(seconds: 1), (int _) {
      final random = Random();
      return random.nextInt(10);
    });
  }
}
