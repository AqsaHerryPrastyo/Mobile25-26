import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key});

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Future<Position>? position;

  @override
  void initState() {
    super.initState();
    position = getPosition();
  }

  // Praktikum 7 - Langkah 1: simplified getPosition for FutureBuilder example
  Future<Position> getPosition() async {
    // ensure location service is enabled, then simulate delay for loading
    await Geolocator.isLocationServiceEnabled();
    await Future.delayed(const Duration(seconds: 3));
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Current Location - Aqsa'),
      ),
      body: Center(
        child: FutureBuilder<Position>(
          future: position,
          builder: (BuildContext context, AsyncSnapshot<Position> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final p = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Latitude: ${p.latitude}, Longitude: ${p.longitude}', textAlign: TextAlign.center),
              );
            } else {
              return const Text('No data');
            }
          },
        ),
      ),
    );
  }
}
