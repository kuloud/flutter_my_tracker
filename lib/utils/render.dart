import 'package:ditredi/ditredi.dart';
import 'package:flutter_my_tracker/models/pojos/position.dart';
import 'package:flutter_my_tracker/utils/color.dart';
import 'package:vector_math/vector_math_64.dart';

extension PositionExtension on Position {
  Point3D toPoint3D() {
    return Point3D(
      Vector3(
        latitude,
        longitude,
        altitude * 0.000009, // 海拔密度和经纬度拉齐，否则D3D显示会因为坐标系问题显示异常
      ),
      color: generateSpeedColor(speed),
    );
  }
}
