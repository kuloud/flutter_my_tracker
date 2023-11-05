// import 'dart:math';

// import 'package:vector_math/vector_math_64.dart';

// class Coordinates {
//   static const double EARTH_RADIUS = 6371.0 * 1000.0; // meters

//   static double distanceBetween(
//       double lon1, double lat1, double lon2, double lat2) {
//     double deltaLon = radians(lon2 - lon1);
//     double deltaLat = radians(lat2 - lat1);
//     double a = pow(sin(deltaLat / 2.0), 2.0) +
//         cos(radians(lat1)) * cos(radians(lat2)) * pow(sin(deltaLon / 2.0), 2.0);
//     double c = 2.0 * atan2(sqrt(a), sqrt(1.0 - a));
//     return EARTH_RADIUS * c;
//   }

//   static double longitudeToMeters(double lon) {
//     double distance = distanceBetween(lon, 0.0, 0.0, 0.0);
//     return distance * (lon < 0.0 ? -1.0 : 1.0);
//   }

//   static GeoPoint metersToGeoPoint(double lonMeters, double latMeters) {
//     GeoPoint point = GeoPoint(0.0, 0.0);
//     GeoPoint pointEast = pointPlusDistanceEast(point, lonMeters);
//     GeoPoint pointNorthEast = pointPlusDistanceNorth(pointEast, latMeters);
//     return pointNorthEast;
//   }

//   static double latitudeToMeters(double lat) {
//     double distance = distanceBetween(0.0, lat, 0.0, 0.0);
//     return distance * (lat < 0.0 ? -1.0 : 1.0);
//   }

//   static GeoPoint getPointAhead(
//       GeoPoint point, double distance, double azimuthDegrees) {
//     double radiusFraction = distance / EARTH_RADIUS;
//     double bearing = radians(azimuthDegrees);
//     double lat1 = radians(point.latitude);
//     double lng1 = radians(point.longitude);
//     double lat2_part1 = sin(lat1) * cos(radiusFraction);
//     double lat2_part2 = cos(lat1) * sin(radiusFraction) * cos(bearing);
//     double lat2 = asin(lat2_part1 + lat2_part2);
//     double lng2_part1 = sin(bearing) * sin(radiusFraction) * cos(lat1);
//     double lng2_part2 = cos(radiusFraction) - sin(lat1) * sin(lat2);
//     double lng2 = lng1 + atan2(lng2_part1, lng2_part2);
//     lng2 = (lng2 + 3.0 * pi) % (2.0 * pi) - pi;
//     GeoPoint res = GeoPoint(degrees(lat2), degrees(lng2));
//     return res;
//   }

//   static GeoPoint pointPlusDistanceEast(GeoPoint point, double distance) {
//     return getPointAhead(point, distance, 90.0);
//   }

//   static GeoPoint pointPlusDistanceNorth(GeoPoint point, double distance) {
//     return getPointAhead(point, distance, 0.0);
//   }

//   static double calculateDistance(List<GeoPoint> track) {
//     double distance = 0.0;
//     double lastLon, lastLat;
//     if (track == null || track.length - 1 <= 0) return 0.0;
//     lastLon = track[0].longitude;
//     lastLat = track[0].latitude;
//     for (int i = 1; i < track.length; ++i) {
//       distance += distanceBetween(
//           lastLat, lastLon, track[i].latitude, track[i].longitude);
//       lastLat = track[i].latitude;
//       lastLon = track[i].longitude;
//     }
//     return distance;
//   }
// }

// class GeoPoint {
//   final double latitude;
//   final double longitude;

//   GeoPoint(this.latitude, this.longitude);
// }
