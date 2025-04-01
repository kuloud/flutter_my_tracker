import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({super.key, this.label});

  final String? label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(children: [
        Image.asset(
          'assets/images/app_logo.png',
          width: 120,
          height: 120,
        ),
        Text(label ?? '')
      ]),
    );
  }
}
