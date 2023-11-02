import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/components/widgets/grid_tile_label_title.dart';

class CardTitleBar extends StatelessWidget {
  const CardTitleBar(
      {super.key, required this.title, this.subtitle, required this.items});

  final String title;
  final String? subtitle;
  final List<Map<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                subtitle ?? '',
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          GridView.count(
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              childAspectRatio: 2.5,
              children: items
                  .mapIndexed((e, i) => SkyGridTileLabelTitle(
                        data: e,
                        textAlign: CrossAxisAlignment.center,
                      ))
                  .toList())
        ],
      ),
    );
  }
}
