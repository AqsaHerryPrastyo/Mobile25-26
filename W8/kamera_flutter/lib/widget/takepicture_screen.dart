import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:kamera_flutter/widget/displaypicture_screen.dart';

// A screen that allows users to take a picture using a given camera.
class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({
    super.key,
    required this.camera,
  });

  final CameraDescription camera;

  @override
  TakePictureScreenState createState() => TakePictureScreenState();
}

class TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      widget.camera,
      // Define the resolution to use.
      ResolutionPreset.medium,
      // Enable audio if you plan to record video with sound.
      enableAudio: true,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Use the future returned by `CameraController.initialize()` to display a
    // loading spinner until the camera is ready, then show the camera preview
    // inside a Scaffold with an AppBar.
    return Scaffold(
      appBar: AppBar(title: const Text('Take a picture - 2341720153')),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until
      // the controller has finished initializing.
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            // If the Future is complete, display the preview with a centered
            // circular capture button overlayed at the bottom.
            return Stack(
              children: [
                // Make the preview fill the available space.
                Positioned.fill(
                  child: CameraPreview(_controller),
                ),
                // Capture button positioned at the bottom center.
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 30,
                  child: Center(
                    child: GestureDetector(
                      onTap: _takePicture,
                      child: Container(
                        width: 80,
                        height: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 6),
                        ),
                        child: Container(
                          width: 56,
                          height: 56,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          } else {
            // Otherwise, display a loading indicator.
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
        // FloatingActionButton removed — capture button is overlayed on preview.
    );
  }

    Future<void> _takePicture() async {
      try {
        // Ensure that the camera is initialized.
        await _initializeControllerFuture;

        // Attempt to take a picture and get the file `image` where it was saved.
        final image = await _controller.takePicture();

        if (!mounted) return;

        // If the picture was taken, display it on a new screen.
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => DisplayPictureScreen(
              // Pass the automatically generated path to the
              // DisplayPictureScreen widget.
              imagePath: image.path,
            ),
          ),
        );
      } catch (e) {
        // If an error occurs, log the error to the console.
        // ignore: avoid_print
        print(e);
      }
    }
}
