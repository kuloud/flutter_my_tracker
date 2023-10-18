import 'package:flutter/material.dart';

class SkyGridTile extends StatelessWidget {
  const SkyGridTile({super.key, required this.data, this.textAlign});

  final Map<String, String> data;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        footer: Text(
          data['label']!,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.labelSmall,
        ),
        child: Text(
          data['title']!,
          textAlign: textAlign,
          style: Theme.of(context)
              .textTheme
              .bodyLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ));
  }
}
