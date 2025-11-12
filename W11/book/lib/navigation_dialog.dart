import 'package:flutter/material.dart';

class NavigationDialogScreen extends StatefulWidget {
  const NavigationDialogScreen({super.key});

  @override
  State<NavigationDialogScreen> createState() => _NavigationDialogScreenState();
}

class _NavigationDialogScreenState extends State<NavigationDialogScreen> {
  Color color = const Color(0xFF1565C0); // default blue-ish

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation Dialog Screen - Aqsa'),
        backgroundColor: color,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _showColorDialog(context),
          child: const Text('Change Color (Dialog)'),
        ),
      ),
    );
  }

  Future<void> _showColorDialog(BuildContext context) async {
    // showDialog returns the selected color (or null if cancelled)
    final selected = await showDialog<Color>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Pilih warna favorit Anda'),
          content: const Text('Silakan pilih warna:'),
          actions: <Widget>[
            TextButton(
              child: const Text('Orange'),
              onPressed: () {
                Navigator.of(context).pop(const Color(0xFFFF6600));
              },
            ),
            TextButton(
              child: const Text('Green'),
              onPressed: () {
                Navigator.of(context).pop(Colors.green.shade700);
              },
            ),
            TextButton(
              child: const Text('Blue'),
              onPressed: () {
                Navigator.of(context).pop(Colors.blue.shade700);
              },
            ),
            TextButton(
              child: const Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        );
      },
    );

    if (selected != null) {
      setState(() {
        color = selected;
      });
    }
  }
}
