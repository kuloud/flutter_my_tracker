import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

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
