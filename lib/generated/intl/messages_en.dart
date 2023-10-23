// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(times) => "${times} Activities";

  static String m1(author, year) => "Copyright © {${author}}, {${year}}";

  static String m2(unit) => "(${unit})";

  static String m3(version, buildNumber) =>
      "Version {${version}}, build #{${buildNumber}}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "activitySummary":
            MessageLookupByLibrary.simpleMessage("Activity Summary"),
        "activityTimes": m0,
        "allActivities": MessageLookupByLibrary.simpleMessage("All Activities"),
        "altitude": MessageLookupByLibrary.simpleMessage("Altitude"),
        "appName": MessageLookupByLibrary.simpleMessage("Flove"),
        "appSlogan": MessageLookupByLibrary.simpleMessage("Love, yourself."),
        "authorYear": m1,
        "averagePace": MessageLookupByLibrary.simpleMessage("Average Pace"),
        "comma": MessageLookupByLibrary.simpleMessage(","),
        "darkTheme": MessageLookupByLibrary.simpleMessage("Dark Theme"),
        "east": MessageLookupByLibrary.simpleMessage("East"),
        "fast": MessageLookupByLibrary.simpleMessage("Fast"),
        "kilometer": MessageLookupByLibrary.simpleMessage("km"),
        "kilometerPerHour": MessageLookupByLibrary.simpleMessage("km/h"),
        "kilometers": MessageLookupByLibrary.simpleMessage("km"),
        "labelAppDescription": MessageLookupByLibrary.simpleMessage(
            "A minimalist movement tracking software that 100% follows the Material You design language."),
        "labelAvgPace": MessageLookupByLibrary.simpleMessage("Avg Pace"),
        "labelPace": MessageLookupByLibrary.simpleMessage("Pace"),
        "labelStep": MessageLookupByLibrary.simpleMessage("Step"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "maxAltitude": MessageLookupByLibrary.simpleMessage("Max Altitude"),
        "maxPace": MessageLookupByLibrary.simpleMessage("Max Pace"),
        "meter": MessageLookupByLibrary.simpleMessage("m"),
        "meters": MessageLookupByLibrary.simpleMessage("m"),
        "minAltitude": MessageLookupByLibrary.simpleMessage("Min Altitude"),
        "minPace": MessageLookupByLibrary.simpleMessage("Min Pace"),
        "minutePerKilometer": MessageLookupByLibrary.simpleMessage("min/km"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "north": MessageLookupByLibrary.simpleMessage("North"),
        "pace": MessageLookupByLibrary.simpleMessage("Pace"),
        "recentActivity":
            MessageLookupByLibrary.simpleMessage("Recent Activity"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sky": MessageLookupByLibrary.simpleMessage("Sky"),
        "slow": MessageLookupByLibrary.simpleMessage("Slow"),
        "toNow": MessageLookupByLibrary.simpleMessage("to Now"),
        "toastDistanceTooShort": MessageLookupByLibrary.simpleMessage(
            "The distance is too short and the data will not be recorded."),
        "total": MessageLookupByLibrary.simpleMessage("Total"),
        "totalDistance": MessageLookupByLibrary.simpleMessage("Total Distance"),
        "totalDuration": MessageLookupByLibrary.simpleMessage("Total Duration"),
        "unit": m2,
        "unitKm": MessageLookupByLibrary.simpleMessage("KM"),
        "unitM": MessageLookupByLibrary.simpleMessage("M"),
        "versionBuild": m3,
        "viewChangelog": MessageLookupByLibrary.simpleMessage("View Changelog"),
        "viewPrivacyPolicy":
            MessageLookupByLibrary.simpleMessage("View Privacy Policy"),
        "viewReadme": MessageLookupByLibrary.simpleMessage("View Readme"),
        "week": MessageLookupByLibrary.simpleMessage("Week"),
        "workoutsTimes": MessageLookupByLibrary.simpleMessage("workouts"),
        "year": MessageLookupByLibrary.simpleMessage("Year")
      };
}
