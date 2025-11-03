import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:kamera_flutter/widget/takepicture_screen.dart';

// Top-level camera descriptor to be initialized before the app runs.
late CameraDescription firstCamera;

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  List<CameraDescription> cameras = <CameraDescription>[];
  try {
    cameras = await availableCameras();
  } catch (e) {
    // If availableCameras fails (permissions, hardware, etc.), log the
    // error and fall through to show an error UI below.
    // ignore: avoid_print
    print('Error fetching available cameras: $e');
  }

  if (cameras.isNotEmpty) {
    // Get a specific camera from the list of available cameras.
    firstCamera = cameras.first;

    runApp(
      MaterialApp(
        theme: ThemeData.dark(),
        home: TakePictureScreen(
          // Pass the appropriate camera to the TakePictureScreen widget.
          camera: firstCamera,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  } else {
    // If no cameras are available, run a simple app that displays an error
    // message instead of crashing.
    runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(title: const Text('Camera error')),
          body: const Center(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'No cameras available or failed to initialize the camera.\n'
                'Check device permissions and try again.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
