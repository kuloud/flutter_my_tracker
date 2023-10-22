import 'package:flutter/material.dart';
import 'package:flutter_my_tracker/generated/l10n.dart';

class PaceGradientBar extends StatelessWidget {
  const PaceGradientBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          S.of(context).slow,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        Expanded(
          child: Container(
            height: 6,
            margin: const EdgeInsets.all(4),
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              gradient: const LinearGradient(
                colors: [
                  Colors.green,
                  Colors.yellow,
                  Colors.red,
                ],
                stops: [0.0, 0.5, 1.0],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
        ),
        Text(
          S.of(context).fast,
          style: Theme.of(context).textTheme.labelMedium,
        ),
      ],
    );
  }
}
