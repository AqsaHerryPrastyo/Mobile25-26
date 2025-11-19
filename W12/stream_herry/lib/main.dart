import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:math';
import 'stream.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stream - Herry',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const StreamHomePage(),

    );
  }
}

class StreamHomePage extends StatefulWidget {
  const StreamHomePage({super.key});

  @override
  State<StreamHomePage> createState() => StreamHomePageState();
}

class StreamHomePageState extends State<StreamHomePage> {
  Color bgColor = Colors.blueGrey;
  late ColorStream colorStream;
  late StreamSubscription<Color> _sub;
  int lastNumber = 0;
  late StreamController<int> numberStreamController;
  late NumberStream numberStream;
  late StreamTransformer<int, int> transformer;
  late StreamSubscription<int> subscription;

  void changeColor() {
    _sub = colorStream.getColors().listen((eventColor) {
      setState(() {
        bgColor = eventColor;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    colorStream = ColorStream();
    changeColor();
    // setup number stream
    numberStream = NumberStream();
    numberStreamController = numberStream.controller;
    Stream<int> stream = numberStreamController.stream;

    // Praktikum 3: buat transformer yang mengalikan nilai dengan 10,
    // menangani error dengan mengirim -1, dan menutup sink saat done.
    transformer = StreamTransformer<int, int>.fromHandlers(
      handleData: (value, EventSink<int> sink) {
        sink.add(value * 10);
      },
      handleError: (error, stackTrace, EventSink<int> sink) {
        sink.add(-1);
      },
      handleDone: (EventSink<int> sink) => sink.close(),
    );

    // Terapkan transformer dan simpan subscription untuk lifecycle control.
    subscription = stream.transform(transformer).listen((event) {
      setState(() {
        lastNumber = event;
      });
    });

    // Tambahkan handler onError dan onDone pada subscription.
    subscription.onError((error) {
      setState(() {
        lastNumber = -1;
      });
    });

    subscription.onDone(() {
      // Notifikasi ketika stream selesai/ditutup.
      // Berguna untuk debugging atau membersihkan state terkait.
      // ignore: avoid_print
      print('OnDone was called');
    });
  }

  @override
  void dispose() {
    // cancel color subscription
    _sub.cancel();
    // cancel number subscription
    subscription.cancel();
    // close number stream controller if not already closed
    if (!numberStreamController.isClosed) {
      numberStream.close();
    }
    super.dispose();
  }

  void addRandomNumber() {
    Random random = Random();
    int myNum = random.nextInt(10);
    if (!numberStreamController.isClosed) {
      numberStream.addNumberToSink(myNum);
    } else {
      setState(() {
        lastNumber = -1;
      });
    }
    // untuk pengujian error: uncomment baris berikut untuk memancarkan error
    // numberStream.addError();
  }

  void stopStream() {
    if (!numberStreamController.isClosed) {
      numberStreamController.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stream - Herry'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Container(
          decoration: BoxDecoration(color: bgColor),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(lastNumber.toString(), style: const TextStyle(fontSize: 48, color: Colors.white)),
              ElevatedButton(
                onPressed: () => addRandomNumber(),
                child: const Text('New Random Number'),
              ),
              ElevatedButton(
                onPressed: () => stopStream(),
                child: const Text('Stop Subscription'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
