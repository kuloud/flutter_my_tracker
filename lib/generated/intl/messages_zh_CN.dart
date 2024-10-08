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

  static String m2(distance) => "总距离: ${distance}";

  static String m3(distance, duration) => "完成了 ${distance}！您已经坚持了 ${duration}。";

  static String m4(unit) => "(${unit})";

  static String m5(version, buildNumber) =>
      "版本 {${version}}, 构建号 #{${buildNumber}}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("关于"),
        "activitySummary": MessageLookupByLibrary.simpleMessage("运动总结"),
        "activityTimes": m0,
        "agree": MessageLookupByLibrary.simpleMessage("同意"),
        "allActivities": MessageLookupByLibrary.simpleMessage("全部运动记录"),
        "altitude": MessageLookupByLibrary.simpleMessage("海拔"),
        "appName": MessageLookupByLibrary.simpleMessage("飞乐"),
        "appSlogan": MessageLookupByLibrary.simpleMessage("飞跃成长，自得其乐。"),
        "authorYear": m1,
        "averagePace": MessageLookupByLibrary.simpleMessage("平均配速"),
        "comma": MessageLookupByLibrary.simpleMessage("，"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("深色主题"),
        "east": MessageLookupByLibrary.simpleMessage("东"),
        "fast": MessageLookupByLibrary.simpleMessage("快"),
        "goOpen": MessageLookupByLibrary.simpleMessage("去开启"),
        "hour": MessageLookupByLibrary.simpleMessage("时"),
        "kilometer": MessageLookupByLibrary.simpleMessage("千米"),
        "kilometerPerHour": MessageLookupByLibrary.simpleMessage("公里/小时"),
        "kilometers": MessageLookupByLibrary.simpleMessage("千米"),
        "lab": MessageLookupByLibrary.simpleMessage("实验室"),
        "labelAppDescription": MessageLookupByLibrary.simpleMessage(
            "一款极简风格的运动轨迹记录软件，100%遵循Material You的设计语言。"),
        "labelAvgPace": MessageLookupByLibrary.simpleMessage("平均配速"),
        "labelPace": MessageLookupByLibrary.simpleMessage("配速"),
        "labelStep": MessageLookupByLibrary.simpleMessage("步数"),
        "language": MessageLookupByLibrary.simpleMessage("语言"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("浅色主题"),
        "locationServiceDisabled":
            MessageLookupByLibrary.simpleMessage("定位服务功能未开启"),
        "maxAltitude": MessageLookupByLibrary.simpleMessage("最高海拔"),
        "maxPace": MessageLookupByLibrary.simpleMessage("最高配速"),
        "meter": MessageLookupByLibrary.simpleMessage("米"),
        "meters": MessageLookupByLibrary.simpleMessage("米"),
        "min": MessageLookupByLibrary.simpleMessage("分"),
        "minAltitude": MessageLookupByLibrary.simpleMessage("最低海拔"),
        "minPace": MessageLookupByLibrary.simpleMessage("最低配速"),
        "minutePerKilometer": MessageLookupByLibrary.simpleMessage("/千米"),
        "month": MessageLookupByLibrary.simpleMessage("月"),
        "newLocationReceived": MessageLookupByLibrary.simpleMessage("定位点更新"),
        "north": MessageLookupByLibrary.simpleMessage("北"),
        "notificationTotalDiatance": m2,
        "pace": MessageLookupByLibrary.simpleMessage("配速"),
        "recentActivity": MessageLookupByLibrary.simpleMessage("最近运动"),
        "refuse": MessageLookupByLibrary.simpleMessage("拒绝"),
        "settings": MessageLookupByLibrary.simpleMessage("设置"),
        "sky": MessageLookupByLibrary.simpleMessage("天"),
        "slow": MessageLookupByLibrary.simpleMessage("慢"),
        "toNow": MessageLookupByLibrary.simpleMessage("至今"),
        "toastDistanceTooShort":
            MessageLookupByLibrary.simpleMessage("距离太短，数据将不会被记录。"),
        "total": MessageLookupByLibrary.simpleMessage("总"),
        "totalDistance": MessageLookupByLibrary.simpleMessage("总距离"),
        "totalDuration": MessageLookupByLibrary.simpleMessage("总时长"),
        "ttsEndRun": m3,
        "ttsStartRun": MessageLookupByLibrary.simpleMessage("让我们开始今天的跑步之旅！"),
        "unauthorizedLocation": MessageLookupByLibrary.simpleMessage("未授权定位权限"),
        "unauthorizedLocationAlways":
            MessageLookupByLibrary.simpleMessage("未授权应用后台运行时访问设备位置的权限定位权限"),
        "unauthorizedLocationDescription": MessageLookupByLibrary.simpleMessage(
            "当前无法获得您在户外运动时的位置，请前往飞乐-权限授权定位权限后使用"),
        "unit": m4,
        "unitKm": MessageLookupByLibrary.simpleMessage("公里"),
        "unitM": MessageLookupByLibrary.simpleMessage("米"),
        "versionBuild": m5,
        "viewChangelog": MessageLookupByLibrary.simpleMessage("查看更新日志"),
        "viewPrivacyPolicy": MessageLookupByLibrary.simpleMessage("查看隐私政策"),
        "viewReadme": MessageLookupByLibrary.simpleMessage("查看自述文件"),
        "week": MessageLookupByLibrary.simpleMessage("周"),
        "workoutsTimes": MessageLookupByLibrary.simpleMessage("次"),
        "year": MessageLookupByLibrary.simpleMessage("年")
      };
}
