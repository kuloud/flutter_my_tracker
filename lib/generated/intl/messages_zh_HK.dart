// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_HK locale. All the
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
  String get localeName => 'zh_HK';

  static String m0(times) => "運動${times}次";

  static String m1(author, year) => "版權所有 © {${author}}, {${year}}";

  static String m2(unit) => "(${unit})";

  static String m3(version, buildNumber) =>
      "版本 {${version}}, 構建號 #{${buildNumber}}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("關於"),
        "activitySummary": MessageLookupByLibrary.simpleMessage("運動總結"),
        "activityTimes": m0,
        "agree": MessageLookupByLibrary.simpleMessage("同意"),
        "allActivities": MessageLookupByLibrary.simpleMessage("全部運動記錄"),
        "altitude": MessageLookupByLibrary.simpleMessage("海拔"),
        "appName": MessageLookupByLibrary.simpleMessage("飛樂"),
        "appSlogan": MessageLookupByLibrary.simpleMessage("飛躍成長，自得其樂。"),
        "authorYear": m1,
        "averagePace": MessageLookupByLibrary.simpleMessage("平均配速"),
        "comma": MessageLookupByLibrary.simpleMessage("，"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("深色主題"),
        "east": MessageLookupByLibrary.simpleMessage("東"),
        "fast": MessageLookupByLibrary.simpleMessage("快"),
        "goOpen": MessageLookupByLibrary.simpleMessage("去開啟"),
        "hour": MessageLookupByLibrary.simpleMessage("時"),
        "kilometer": MessageLookupByLibrary.simpleMessage("千米"),
        "kilometerPerHour": MessageLookupByLibrary.simpleMessage("公里/小時"),
        "kilometers": MessageLookupByLibrary.simpleMessage("千米"),
        "lab": MessageLookupByLibrary.simpleMessage("實驗室"),
        "labelAppDescription": MessageLookupByLibrary.simpleMessage(
            "一款極簡風格的運動軌跡記錄軟件，100%遵循Material You的設計語言。"),
        "labelAvgPace": MessageLookupByLibrary.simpleMessage("平均配速"),
        "labelPace": MessageLookupByLibrary.simpleMessage("配速"),
        "labelStep": MessageLookupByLibrary.simpleMessage("步數"),
        "language": MessageLookupByLibrary.simpleMessage("語言"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("淺色主題"),
        "locationServiceDisabled":
            MessageLookupByLibrary.simpleMessage("定位服務功能未開啟"),
        "maxAltitude": MessageLookupByLibrary.simpleMessage("最高海拔"),
        "maxPace": MessageLookupByLibrary.simpleMessage("最高配速"),
        "meter": MessageLookupByLibrary.simpleMessage("米"),
        "meters": MessageLookupByLibrary.simpleMessage("米"),
        "min": MessageLookupByLibrary.simpleMessage("分"),
        "minAltitude": MessageLookupByLibrary.simpleMessage("最低海拔"),
        "minPace": MessageLookupByLibrary.simpleMessage("最低配速"),
        "minutePerKilometer": MessageLookupByLibrary.simpleMessage("分/千米"),
        "month": MessageLookupByLibrary.simpleMessage("月"),
        "north": MessageLookupByLibrary.simpleMessage("北"),
        "pace": MessageLookupByLibrary.simpleMessage("配速"),
        "recentActivity": MessageLookupByLibrary.simpleMessage("最近運動"),
        "refuse": MessageLookupByLibrary.simpleMessage("拒絕"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "sky": MessageLookupByLibrary.simpleMessage("天"),
        "slow": MessageLookupByLibrary.simpleMessage("慢"),
        "toNow": MessageLookupByLibrary.simpleMessage("至今"),
        "toastDistanceTooShort":
            MessageLookupByLibrary.simpleMessage("距離太短，數據將不會被記錄。"),
        "total": MessageLookupByLibrary.simpleMessage("總"),
        "totalDistance": MessageLookupByLibrary.simpleMessage("總距離"),
        "totalDuration": MessageLookupByLibrary.simpleMessage("總時長"),
        "unauthorizedLocation": MessageLookupByLibrary.simpleMessage("未授權定位權限"),
        "unauthorizedLocationAlways":
            MessageLookupByLibrary.simpleMessage("未授權應用後台運行時訪問設備位置的權限定位權限"),
        "unauthorizedLocationDescription": MessageLookupByLibrary.simpleMessage(
            "當前無法獲得您在戶外運動時的位置，請前往飛樂-權限授權定位權限後使用"),
        "unit": m2,
        "unitKm": MessageLookupByLibrary.simpleMessage("公里"),
        "unitM": MessageLookupByLibrary.simpleMessage("米"),
        "versionBuild": m3,
        "viewChangelog": MessageLookupByLibrary.simpleMessage("查看更新日誌"),
        "viewPrivacyPolicy": MessageLookupByLibrary.simpleMessage("查看隱私政策"),
        "viewReadme": MessageLookupByLibrary.simpleMessage("查看自述文件"),
        "week": MessageLookupByLibrary.simpleMessage("週"),
        "workoutsTimes": MessageLookupByLibrary.simpleMessage("次"),
        "year": MessageLookupByLibrary.simpleMessage("年")
      };
}
