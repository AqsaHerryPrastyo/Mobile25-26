import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import 'model/pizza.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JSON',
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: const MyHomePage(title: 'JSON'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // legacy template counter (not used for praktikum tasks)
  // kept intentionally for reference; remove if you want to clean lints
  int _counter = 0;
  List<Pizza> myPizzas = [];
  int appCounter = 0;
  String documentsPath = '';
  String tempPath = '';
  // Praktikum 6: file handling
  late File myFile;
  String fileText = '';

  @override
  void initState() {
    super.initState();
    readJsonFile().then((value) {
      setState(() {
        myPizzas = value;
      });
    }).catchError((err) {
      // If loading/parsing fails, keep an empty list and log the error.
      // This prevents calling `.isEmpty` on an undefined value at runtime.
      debugPrint('Error loading pizzas: $err');
      setState(() {
        myPizzas = [];
      });
    });
    // Praktikum 4: read and increment app open counter
    readAndWritePreference();
    // Praktikum 5: get application document and temporary directory paths
    // After paths are available, initialize file and write default content (Praktikum 6)
    getPaths().then((_) {
      try {
        myFile = File('\$documentsPath/pizzas.txt');
        // write initial content; replace with your full name and NIM if desired
        writeFile();
      } catch (e) {
        debugPrint('Error initializing myFile: $e');
      }
    });
  }

  // Praktikum 5: obtain documents and temporary directory paths
  Future<void> getPaths() async {
    try {
      final docDir = await getApplicationDocumentsDirectory();
      final tempDir = await getTemporaryDirectory();
      setState(() {
        documentsPath = docDir.path;
        tempPath = tempDir.path;
      });
    } catch (e) {
      debugPrint('getPaths error: $e');
    }
  }

  Future<List<Pizza>> readJsonFile() async {
    try {
      final String myString = await rootBundle.loadString('assets/pizzalist.json');
      if (myString.trim().isEmpty) return [];
      final List<dynamic> pizzaMapList = jsonDecode(myString);
      final List<Pizza> pizzas = [];
      for (var pizzaMap in pizzaMapList) {
        pizzas.add(Pizza.fromJson(Map<String, dynamic>.from(pizzaMap)));
      }
      // Convert back to JSON string and print (practicum step)
      try {
        final String jsonOut = convertToJSON(pizzas);
        debugPrint('Converted JSON: $jsonOut');
      } catch (e) {
        debugPrint('Error converting pizzas to JSON: $e');
      }
      return pizzas;
    } catch (e) {
      debugPrint('readJsonFile error: $e');
      return [];
    }
  }

  // Praktikum 4: SharedPreferences read/increment
  Future<void> readAndWritePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      int count = prefs.getInt('appCounter') ?? 0;
      count++;
      await prefs.setInt('appCounter', count);
      setState(() {
        appCounter = count;
      });
    } catch (e) {
      debugPrint('SharedPreferences error: $e');
    }
  }

  Future<void> resetCounter() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt('appCounter', 0);
      setState(() {
        appCounter = 0;
      });
    } catch (e) {
      debugPrint('SharedPreferences error (reset): $e');
    }
  }

  // Praktikum 4: delete all preferences (uses prefs.clear()) and reset counter
  Future<void> deletePreference() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
      setState(() {
        appCounter = 0;
      });
    } catch (e) {
      debugPrint('SharedPreferences error (delete): $e');
    }
  }

  // Praktikum 6: write text to a file in application documents directory
  Future<bool> writeFile() async {
    try {
      // Default content — replace with your full name and NIM if required
      const String content = 'Margherita, Capricciosa, Napoli';
      await myFile.writeAsString(content);
      return true;
    } catch (e) {
      debugPrint('writeFile error: $e');
      return false;
    }
  }

  // Praktikum 6: read file content and update UI
  Future<bool> readFile() async {
    try {
      if (!await myFile.exists()) {
        setState(() {
          fileText = 'File not found: ${myFile.path}';
        });
        return false;
      }
      final String content = await myFile.readAsString();
      setState(() {
        fileText = content;
      });
      return true;
    } catch (e) {
      debugPrint('readFile error: $e');
      return false;
    }
  }

  String convertToJSON(List<Pizza> pizzas) {
    return jsonEncode(pizzas.map((p) => p.toJson()).toList());
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('You have opened the app $appCounter times.'),
            const SizedBox(height: 12),
            // Praktikum 5: show paths obtained from path_provider
            Text('Doc path: $documentsPath', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 6),
            Text('Temp path: $tempPath', style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await deletePreference();
              },
              child: const Text('Reset counter'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () async {
                await readFile();
              },
              child: const Text('Read File'),
            ),
            const SizedBox(height: 8),
            Text(fileText),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
