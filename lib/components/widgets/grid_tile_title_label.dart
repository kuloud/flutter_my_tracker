import 'package:flutter/material.dart';

class SkyGridTileTitleLabel extends StatelessWidget {
  const SkyGridTileTitleLabel({super.key, required this.data, this.textAlign});

  final Map<String, String> data;
  final CrossAxisAlignment? textAlign;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: textAlign ?? CrossAxisAlignment.start,
      children: [
        Text(
          data['title']!,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        Text(
          data['label']!,
          style: Theme.of(context).textTheme.labelSmall,
        ),
      ],
    ));
  }
}
