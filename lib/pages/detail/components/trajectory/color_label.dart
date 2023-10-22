import 'package:flutter/material.dart';

class ColorLabels extends StatelessWidget {
  const ColorLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'color': Colors.green, 'label': '东'},
      {'color': Colors.blue, 'label': '北'},
      {'color': Colors.red, 'label': '天'}
    ];
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items
            .map((e) => Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: e['color'] as Color,
                      size: 8,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text('${e['label']}')
                  ],
                ))
            .toList(),
      ),
    );
  }
}
