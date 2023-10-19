import 'package:flutter/material.dart';

/// 上label 下title
class SkyGridTile extends StatelessWidget {
  const SkyGridTile({super.key, required this.data, this.textAlign});

  final Map<String, String> data;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        footer: Text(
          data['title']!,
          textAlign: textAlign,
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        child: Text(
          data['label']!,
          textAlign: textAlign,
          style: Theme.of(context).textTheme.labelSmall,
        ));
  }
}
