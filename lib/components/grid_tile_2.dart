import 'package:flutter/material.dart';

/// 上label 下title
class SkyGridTile extends StatelessWidget {
  const SkyGridTile({super.key, required this.data, this.textAlign});

  final Map<String, String> data;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return GridTile(
        child: GridTileBar(
      title: Text(
        data['label']!,
        textAlign: textAlign,
        style: Theme.of(context).textTheme.labelSmall,
      ),
      subtitle: Text(
        data['title']!,
        textAlign: textAlign,
        style: Theme.of(context)
            .textTheme
            .titleMedium
            ?.copyWith(color: Theme.of(context).colorScheme.primary),
      ),
    ));
  }
}
