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

  static String m1(author, year) => "© {${author}}, {${year}}";

  static String m2(unit) => "(${unit})";

  static String m3(version, buildNumber) =>
      "Version {${version}}, Build #{${buildNumber}}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("About"),
        "activitySummary":
            MessageLookupByLibrary.simpleMessage("Activity Summary"),
        "activityTimes": m0,
        "agree": MessageLookupByLibrary.simpleMessage("Agree"),
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
        "goOpen": MessageLookupByLibrary.simpleMessage("Go Open"),
        "hour": MessageLookupByLibrary.simpleMessage("h"),
        "kilometer": MessageLookupByLibrary.simpleMessage("km"),
        "kilometerPerHour": MessageLookupByLibrary.simpleMessage("km/h"),
        "kilometers": MessageLookupByLibrary.simpleMessage("km"),
        "lab": MessageLookupByLibrary.simpleMessage("Lab"),
        "labelAppDescription": MessageLookupByLibrary.simpleMessage(
            "A minimalist-style activity tracking app that follows the design language of Material You."),
        "labelAvgPace": MessageLookupByLibrary.simpleMessage("Avg Pace"),
        "labelPace": MessageLookupByLibrary.simpleMessage("Pace"),
        "labelStep": MessageLookupByLibrary.simpleMessage("Steps"),
        "language": MessageLookupByLibrary.simpleMessage("Language"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("Light Theme"),
        "locationServiceDisabled":
            MessageLookupByLibrary.simpleMessage("Location Services Disabled"),
        "maxAltitude": MessageLookupByLibrary.simpleMessage("Max Altitude"),
        "maxPace": MessageLookupByLibrary.simpleMessage("Max Pace"),
        "meter": MessageLookupByLibrary.simpleMessage("m"),
        "meters": MessageLookupByLibrary.simpleMessage("m"),
        "min": MessageLookupByLibrary.simpleMessage("m"),
        "minAltitude": MessageLookupByLibrary.simpleMessage("Min Altitude"),
        "minPace": MessageLookupByLibrary.simpleMessage("Min Pace"),
        "minutePerKilometer": MessageLookupByLibrary.simpleMessage("min/km"),
        "month": MessageLookupByLibrary.simpleMessage("Month"),
        "north": MessageLookupByLibrary.simpleMessage("North"),
        "pace": MessageLookupByLibrary.simpleMessage("Pace"),
        "recentActivity":
            MessageLookupByLibrary.simpleMessage("Recent Activity"),
        "refuse": MessageLookupByLibrary.simpleMessage("Refuse"),
        "settings": MessageLookupByLibrary.simpleMessage("Settings"),
        "sky": MessageLookupByLibrary.simpleMessage("Sky"),
        "slow": MessageLookupByLibrary.simpleMessage("Slow"),
        "toNow": MessageLookupByLibrary.simpleMessage("to Now"),
        "toastDistanceTooShort": MessageLookupByLibrary.simpleMessage(
            "Distance is too short, data will not be recorded."),
        "total": MessageLookupByLibrary.simpleMessage("Total"),
        "totalDistance": MessageLookupByLibrary.simpleMessage("Total Distance"),
        "totalDuration": MessageLookupByLibrary.simpleMessage("Total Duration"),
        "unauthorizedLocation": MessageLookupByLibrary.simpleMessage(
            "Unauthorized permission to access device location."),
        "unauthorizedLocationAlways": MessageLookupByLibrary.simpleMessage(
            "Unauthorized permission to access device location when the app is running in the background."),
        "unauthorizedLocationDescription": MessageLookupByLibrary.simpleMessage(
            "Unable to access your outdoor location. Please go to Flove - Permissions to grant location access."),
        "unit": m2,
        "unitKm": MessageLookupByLibrary.simpleMessage("km"),
        "unitM": MessageLookupByLibrary.simpleMessage("m"),
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
