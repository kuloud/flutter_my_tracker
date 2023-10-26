import 'dart:math';

import 'package:flutter_my_tracker/models/pojos/position.dart';

class TrackGenerator {
  final double initialAltitude;
  final double finalAltitude;
  final double maxPace;
  final double minPace;
  final double averagePace;
  final double timeDuration;

  TrackGenerator({
    required this.initialAltitude,
    required this.finalAltitude,
    required this.maxPace,
    required this.minPace,
    required this.averagePace,
    required this.timeDuration,
  });

  List<Position> generateTrack() {
    List<Position> track = [];

    double currentAltitude = initialAltitude;

    for (int i = 0; i < timeDuration; i++) {
      double pace = generateRandomPace();
      double altitudeChange = generateRandomAltitudeChange();

      if (currentAltitude + altitudeChange > finalAltitude) {
        altitudeChange = finalAltitude - currentAltitude;
      }

      currentAltitude += altitudeChange;

      // // Simulate movement based on pace
      // double distance =
      //     pace * 0.1; // Assuming 1 unit of pace = 0.1 unit of distance
      // // Update track with distance traveled
      // for (int j = 0; j < track.length - 1; j++) {
      //   track[j] += distance;
      // }

      // Position currentPosition = Position(
      //     latitude: latitude,
      //     longitude: longitude,
      //     accuracy: accuracy,
      //     altitude: altitude,
      //     speed: speed,
      //     speedAccuracy: speedAccuracy,
      //     heading: heading,
      //     time: time,
      //     isMocked: isMocked,
      //     provider: provider);
      // track.add(currentPosition);
    }

    return track;
  }

  double generateRandomPace() {
    Random random = Random();
    return minPace + random.nextDouble() * (maxPace - minPace);
  }

  double generateRandomAltitudeChange() {
    Random random = Random();
    double maxChange = (finalAltitude - initialAltitude) / timeDuration;
    return random.nextDouble() * maxChange;
  }
}
