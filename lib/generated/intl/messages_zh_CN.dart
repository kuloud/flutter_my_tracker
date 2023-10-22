// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
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
  String get localeName => 'zh_CN';

  static String m0(author, year) => "版权所有 © {${author}}, {${year}}";

  static String m1(version, buildNumber) =>
      "版本 {${version}}, 编译号 #{${buildNumber}}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "appName": MessageLookupByLibrary.simpleMessage("飞乐"),
        "authorYear": m0,
        "bottomNavigationBarLabelHistory":
            MessageLookupByLibrary.simpleMessage("History"),
        "bottomNavigationBarLabelMap":
            MessageLookupByLibrary.simpleMessage("Map"),
        "bottomNavigationBarLabelTracks":
            MessageLookupByLibrary.simpleMessage("Tracks"),
        "labelAppDescription": MessageLookupByLibrary.simpleMessage(
            "一款极简风格的运动轨迹记录软件，100%遵循Material You的设计语言。"),
        "labelAvgPace": MessageLookupByLibrary.simpleMessage("平均配速"),
        "labelPace": MessageLookupByLibrary.simpleMessage("配速"),
        "labelStep": MessageLookupByLibrary.simpleMessage("步数"),
        "titleAbout": MessageLookupByLibrary.simpleMessage("关于"),
        "unitKm": MessageLookupByLibrary.simpleMessage("公里"),
        "unitM": MessageLookupByLibrary.simpleMessage("米"),
        "versionBuild": m1,
        "viewReadme": MessageLookupByLibrary.simpleMessage("查看自述文件")
      };
}
