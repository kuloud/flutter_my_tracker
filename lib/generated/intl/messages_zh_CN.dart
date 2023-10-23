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

  static String m0(times) => "运动${times}次";

  static String m1(author, year) => "版权所有 © {${author}}, {${year}}";

  static String m2(unit) => "(${unit})";

  static String m3(version, buildNumber) =>
      "版本 {${version}}, 构建号 #{${buildNumber}}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "activitySummary": MessageLookupByLibrary.simpleMessage("运动总结"),
        "activityTimes": m0,
        "allActivities": MessageLookupByLibrary.simpleMessage("全部运动记录"),
        "altitude": MessageLookupByLibrary.simpleMessage("海拔"),
        "appName": MessageLookupByLibrary.simpleMessage("飞乐"),
        "authorYear": m1,
        "averagePace": MessageLookupByLibrary.simpleMessage("平均配速"),
        "bottomNavigationBarLabelHistory":
            MessageLookupByLibrary.simpleMessage("History"),
        "bottomNavigationBarLabelMap":
            MessageLookupByLibrary.simpleMessage("Map"),
        "bottomNavigationBarLabelTracks":
            MessageLookupByLibrary.simpleMessage("Tracks"),
        "comma": MessageLookupByLibrary.simpleMessage("，"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("深色主题"),
        "east": MessageLookupByLibrary.simpleMessage("东"),
        "fast": MessageLookupByLibrary.simpleMessage("快"),
        "kilometer": MessageLookupByLibrary.simpleMessage("千米"),
        "kilometerPerHour": MessageLookupByLibrary.simpleMessage("公里/小时"),
        "kilometers": MessageLookupByLibrary.simpleMessage("千米"),
        "labelAppDescription": MessageLookupByLibrary.simpleMessage(
            "一款极简风格的运动轨迹记录软件，100%遵循Material You的设计语言。"),
        "labelAvgPace": MessageLookupByLibrary.simpleMessage("平均配速"),
        "labelPace": MessageLookupByLibrary.simpleMessage("配速"),
        "labelStep": MessageLookupByLibrary.simpleMessage("步数"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("浅色主题"),
        "maxAltitude": MessageLookupByLibrary.simpleMessage("最高海拔"),
        "maxPace": MessageLookupByLibrary.simpleMessage("最高配速"),
        "meter": MessageLookupByLibrary.simpleMessage("米"),
        "meters": MessageLookupByLibrary.simpleMessage("米"),
        "minAltitude": MessageLookupByLibrary.simpleMessage("最低海拔"),
        "minPace": MessageLookupByLibrary.simpleMessage("最低配速"),
        "minutePerKilometer": MessageLookupByLibrary.simpleMessage("分/千米"),
        "month": MessageLookupByLibrary.simpleMessage("月"),
        "north": MessageLookupByLibrary.simpleMessage("北"),
        "pace": MessageLookupByLibrary.simpleMessage("配速"),
        "recentActivity": MessageLookupByLibrary.simpleMessage("最近运动"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "sky": MessageLookupByLibrary.simpleMessage("天"),
        "slow": MessageLookupByLibrary.simpleMessage("慢"),
        "titleAbout": MessageLookupByLibrary.simpleMessage("关于"),
        "toNow": MessageLookupByLibrary.simpleMessage("至今"),
        "toastDistanceTooShort":
            MessageLookupByLibrary.simpleMessage("距离太短，数据将不会被记录。"),
        "total": MessageLookupByLibrary.simpleMessage("总"),
        "totalDistance": MessageLookupByLibrary.simpleMessage("总距离"),
        "totalDuration": MessageLookupByLibrary.simpleMessage("总时长"),
        "unit": m2,
        "unitKm": MessageLookupByLibrary.simpleMessage("公里"),
        "unitM": MessageLookupByLibrary.simpleMessage("米"),
        "versionBuild": m3,
        "viewChangelog": MessageLookupByLibrary.simpleMessage("查看更新日志"),
        "viewPrivacyPolicy": MessageLookupByLibrary.simpleMessage("查看隐私政策"),
        "viewReadme": MessageLookupByLibrary.simpleMessage("查看自述文件"),
        "week": MessageLookupByLibrary.simpleMessage("周"),
        "year": MessageLookupByLibrary.simpleMessage("年")
      };
}
