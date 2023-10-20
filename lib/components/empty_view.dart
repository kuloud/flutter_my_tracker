import 'package:ditredi/ditredi.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class EmptyView extends StatefulWidget {
  const EmptyView({super.key});

  @override
  State<EmptyView> createState() => _EmptyViewState();
}

class _EmptyViewState extends State<EmptyView> {
  final _controller = DiTreDiController(
    rotationX: -20,
    rotationY: 30,
    light: vector.Vector3(-0.5, -0.5, 0.5),
  );

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DiTreDiDraggable(
        controller: _controller,
        child: DiTreDi(
          figures: _generateCubes().toList(),
          controller: _controller,
          config: const DiTreDiConfig(
            defaultPointWidth: 4,
            supportZIndex: false,
          ),
        ),
      ),
    );
  }
}

Iterable<Point3D> _generateCubes() sync* {
  final colors = [
    Colors.lightBlue.shade200,
    Colors.lightBlue.shade300,
    Colors.lightBlue.shade400,
    Colors.lightBlue.shade500,
    Colors.lightBlue.shade600,
    Colors.lightBlue.shade700,
    Colors.lightBlue.shade800,
    Colors.lightBlue.shade900,
  ];

  const count = 5;
  for (var x = count; x > 0; x--) {
    for (var y = count; y > 0; y--) {
      for (var z = count; z > 0; z--) {
        yield Point3D(
          vector.Vector3(
            x.toDouble() * 2,
            y.toDouble() * 2,
            z.toDouble() * 2,
          ),
          color: colors[(colors.length - y) % colors.length],
        );
      }
    }
  }
}
