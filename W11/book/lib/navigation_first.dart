import 'package:flutter/material.dart';
import 'navigation_second.dart';

class NavigationFirst extends StatefulWidget {
  const NavigationFirst({super.key});

  @override
  State<NavigationFirst> createState() => _NavigationFirstState();
}

class _NavigationFirstState extends State<NavigationFirst> {
  // Set initial theme/background color to user's favorite: orange #FF6600
  Color color = const Color(0xFFFF6600);

  Future<void> _navigateAndGetColor(BuildContext context) async {
    final result = await Navigator.of(context).push<Color>(
      MaterialPageRoute(builder: (_) => const NavigationSecond()),
    );
    if (result != null) {
      setState(() {
        color = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        title: const Text('Navigation First Screen - Aqsa'),
        backgroundColor: color,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _navigateAndGetColor(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: useWhiteForeground(color) ? Colors.white.withOpacity(0.2) : Colors.black26,
          ),
          child: const Padding(
            padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            child: Text('Change Color', style: TextStyle(fontSize: 16)),
          ),
        ),
      ),
    );
  }

  // Reuse same contrast helper from second screen
  static bool useWhiteForeground(Color backgroundColor) {
    final r = backgroundColor.red / 255.0;
    final g = backgroundColor.green / 255.0;
    final b = backgroundColor.blue / 255.0;
    final luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;
    return luminance < 0.6;
  }
}
