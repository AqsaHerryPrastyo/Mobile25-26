import 'package:flutter/material.dart';

class NavigationSecond extends StatelessWidget {
  const NavigationSecond({super.key});

  @override
  Widget build(BuildContext context) {
    // A small palette of colors to choose from
    final options = <Map<String, dynamic>>[
      {'name': 'Orange', 'color': const Color(0xFFFF6600)},
      {'name': 'Blue', 'color': Colors.blue},
      {'name': 'Green', 'color': Colors.green},
      {'name': 'Red', 'color': Colors.red},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Select Color - Aqsa')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose a color (tap to return):',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 12),
            ...options.map((opt) {
              final c = opt['color'] as Color;
              final name = opt['name'] as String;
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: c,
                    foregroundColor: useWhiteForeground(c) ? Colors.white : Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  onPressed: () => Navigator.of(context).pop(c),
                  child: Text(name, style: const TextStyle(fontSize: 16)),
                ),
              );
            }).toList(),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }

  // Simple luminance check to decide white/black foreground for contrast
  static bool useWhiteForeground(Color backgroundColor) {
    // Per ITU-R BT.709 luminance
    final r = backgroundColor.red / 255.0;
    final g = backgroundColor.green / 255.0;
    final b = backgroundColor.blue / 255.0;
    final luminance = 0.2126 * r + 0.7152 * g + 0.0722 * b;
    return luminance < 0.6;
  }
}
