import 'dart:math';

class SensorGpsDataItem implements Comparable<SensorGpsDataItem> {
  double timestamp;
  double gpsLat;
  double gpsLon;
  double gpsAlt;
  double absNorthAcc;
  double absEastAcc;
  double absUpAcc;
  double speed;
  double course;
  double posErr;
  double velErr;

  static const double NOT_INITIALIZED = 361.0;

  SensorGpsDataItem(
      {required this.timestamp,
      required this.gpsLat,
      required this.gpsLon,
      required this.gpsAlt,
      required this.absNorthAcc,
      required this.absEastAcc,
      required this.absUpAcc,
      required this.speed,
      required this.course,
      required this.posErr,
      required this.velErr,
      required double declination}) {
    this.absNorthAcc =
        absNorthAcc * cos(declination) + absEastAcc * sin(declination);
    this.absEastAcc =
        absEastAcc * cos(declination) - absNorthAcc * sin(declination);
  }

  double getTimestamp() {
    return timestamp;
  }

  double getGpsLat() {
    return gpsLat;
  }

  double getGpsLon() {
    return gpsLon;
  }

  double getGpsAlt() {
    return gpsAlt;
  }

  double getAbsNorthAcc() {
    return absNorthAcc;
  }

  double getAbsEastAcc() {
    return absEastAcc;
  }

  double getAbsUpAcc() {
    return absUpAcc;
  }

  double getSpeed() {
    return speed;
  }

  double getCourse() {
    return course;
  }

  double getPosErr() {
    return posErr;
  }

  double getVelErr() {
    return velErr;
  }

  @override
  int compareTo(SensorGpsDataItem other) {
    return timestamp.compareTo(other.timestamp);
  }
}
