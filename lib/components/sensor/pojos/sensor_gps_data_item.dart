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

  static const double NOT_INITIALIZED = double.infinity;

  SensorGpsDataItem(
      {required this.timestamp,
      this.gpsLat = NOT_INITIALIZED,
      this.gpsLon = NOT_INITIALIZED,
      this.gpsAlt = NOT_INITIALIZED,
      this.absNorthAcc = NOT_INITIALIZED,
      this.absEastAcc = NOT_INITIALIZED,
      this.absUpAcc = NOT_INITIALIZED,
      this.speed = NOT_INITIALIZED,
      this.course = NOT_INITIALIZED,
      this.posErr = NOT_INITIALIZED,
      this.velErr = NOT_INITIALIZED,
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
