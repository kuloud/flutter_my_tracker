import 'dart:io';

import 'package:ditredi/ditredi.dart';
import 'package:stack_trace/stack_trace.dart' as stacktrace;

Future<Mesh3D> getObjModel(String filename) async {
  final faces = await ObjParser().loadFromResources("assets/mesh_3d/$filename");
  return Mesh3D(faces);
}
