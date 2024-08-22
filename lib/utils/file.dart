import 'package:ditredi/ditredi.dart';

Future<Mesh3D> getObjModel(String filename) async {
  final faces = await ObjParser().loadFromResources("assets/mesh_3d/$filename");
  return Mesh3D(faces);
}
