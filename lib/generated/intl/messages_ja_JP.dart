// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ja_JP locale. All the
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
  String get localeName => 'ja_JP';

  static String m0(times) => "${times}回の活動";

  static String m1(author, year) => "著作権所有 © {${author}}, {${year}}";

  static String m2(unit) => "(${unit})";

  static String m3(version, buildNumber) =>
      "バージョン {${version}}, ビルド番号 #{${buildNumber}}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("について"),
        "activitySummary": MessageLookupByLibrary.simpleMessage("活動概要"),
        "activityTimes": m0,
        "agree": MessageLookupByLibrary.simpleMessage("同意する"),
        "allActivities": MessageLookupByLibrary.simpleMessage("すべての活動履歴"),
        "altitude": MessageLookupByLibrary.simpleMessage("高度"),
        "appName": MessageLookupByLibrary.simpleMessage("Flove"),
        "appSlogan": MessageLookupByLibrary.simpleMessage("成長を飛躍させ、楽しみましょう。"),
        "authorYear": m1,
        "averagePace": MessageLookupByLibrary.simpleMessage("平均ペース"),
        "comma": MessageLookupByLibrary.simpleMessage("、"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("ダークテーマ"),
        "east": MessageLookupByLibrary.simpleMessage("東"),
        "fast": MessageLookupByLibrary.simpleMessage("速い"),
        "goOpen": MessageLookupByLibrary.simpleMessage("開く"),
        "hour": MessageLookupByLibrary.simpleMessage("时"),
        "kilometer": MessageLookupByLibrary.simpleMessage("キロメートル"),
        "kilometerPerHour": MessageLookupByLibrary.simpleMessage("キロメートル/時"),
        "kilometers": MessageLookupByLibrary.simpleMessage("キロメートル"),
        "lab": MessageLookupByLibrary.simpleMessage("实验室"),
        "labelAppDescription": MessageLookupByLibrary.simpleMessage(
            "シンプルなデザインの運動トラッキングアプリで、Material Youのデザイン言語に100%準拠しています。"),
        "labelAvgPace": MessageLookupByLibrary.simpleMessage("平均ペース"),
        "labelPace": MessageLookupByLibrary.simpleMessage("ペース"),
        "labelStep": MessageLookupByLibrary.simpleMessage("歩数"),
        "language": MessageLookupByLibrary.simpleMessage("言語"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("ライトテーマ"),
        "locationServiceDisabled":
            MessageLookupByLibrary.simpleMessage("位置情報サービスが無効です"),
        "maxAltitude": MessageLookupByLibrary.simpleMessage("最高高度"),
        "maxPace": MessageLookupByLibrary.simpleMessage("最高ペース"),
        "meter": MessageLookupByLibrary.simpleMessage("メートル"),
        "meters": MessageLookupByLibrary.simpleMessage("メートル"),
        "min": MessageLookupByLibrary.simpleMessage("分"),
        "minAltitude": MessageLookupByLibrary.simpleMessage("最低高度"),
        "minPace": MessageLookupByLibrary.simpleMessage("最低ペース"),
        "minutePerKilometer": MessageLookupByLibrary.simpleMessage("分/キロメートル"),
        "month": MessageLookupByLibrary.simpleMessage("月"),
        "north": MessageLookupByLibrary.simpleMessage("北"),
        "pace": MessageLookupByLibrary.simpleMessage("ペース"),
        "recentActivity": MessageLookupByLibrary.simpleMessage("最近の活動"),
        "refuse": MessageLookupByLibrary.simpleMessage("拒否する"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "sky": MessageLookupByLibrary.simpleMessage("空"),
        "slow": MessageLookupByLibrary.simpleMessage("遅い"),
        "toNow": MessageLookupByLibrary.simpleMessage("現在まで"),
        "toastDistanceTooShort":
            MessageLookupByLibrary.simpleMessage("距離が短すぎて、データは記録されません。"),
        "total": MessageLookupByLibrary.simpleMessage("合計"),
        "totalDistance": MessageLookupByLibrary.simpleMessage("総距離"),
        "totalDuration": MessageLookupByLibrary.simpleMessage("合計時間"),
        "unauthorizedLocation":
            MessageLookupByLibrary.simpleMessage("位置情報の許可がありません"),
        "unauthorizedLocationDescription": MessageLookupByLibrary.simpleMessage(
            "屋外での活動中に位置情報にアクセスできません。Flelo - アクセス許可設定で位置情報の許可を設定してください。"),
        "unit": m2,
        "unitKm": MessageLookupByLibrary.simpleMessage("キロメートル"),
        "unitM": MessageLookupByLibrary.simpleMessage("メートル"),
        "versionBuild": m3,
        "viewChangelog": MessageLookupByLibrary.simpleMessage("変更履歴を表示"),
        "viewPrivacyPolicy":
            MessageLookupByLibrary.simpleMessage("プライバシーポリシーを表示"),
        "viewReadme": MessageLookupByLibrary.simpleMessage("自述ファイルを表示"),
        "week": MessageLookupByLibrary.simpleMessage("週"),
        "workoutsTimes": MessageLookupByLibrary.simpleMessage("回"),
        "year": MessageLookupByLibrary.simpleMessage("年")
      };
}
