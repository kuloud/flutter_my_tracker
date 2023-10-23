import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';

class ColorLabels extends StatelessWidget {
  const ColorLabels({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'color': Colors.green, 'label': S.of(context).east},
      {'color': Colors.blue, 'label': S.of(context).north},
      {'color': Colors.red, 'label': S.of(context).sky}
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
