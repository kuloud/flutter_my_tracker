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

  static String m1(author, year) => "© {${author}}, {${year}}";

  static String m2(distance) => "Total Distance: ${distance}";

  static String m3(distance, duration) =>
      "${distance}を達成しました！あなたは${duration}間走りました。";

  static String m4(unit) => "(${unit})";

  static String m5(version, buildNumber) =>
      "バージョン {${version}}, ビルド #{${buildNumber}}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about": MessageLookupByLibrary.simpleMessage("アプリについて"),
        "activitySummary": MessageLookupByLibrary.simpleMessage("活動の概要"),
        "activityTimes": m0,
        "agree": MessageLookupByLibrary.simpleMessage("同意する"),
        "allActivities": MessageLookupByLibrary.simpleMessage("すべての活動"),
        "altitude": MessageLookupByLibrary.simpleMessage("高度"),
        "appName": MessageLookupByLibrary.simpleMessage("フィロ"),
        "appSlogan": MessageLookupByLibrary.simpleMessage("成長を飛躍させ、楽しみましょう。"),
        "authorYear": m1,
        "averagePace": MessageLookupByLibrary.simpleMessage("平均ペース"),
        "comma": MessageLookupByLibrary.simpleMessage("、"),
        "darkTheme": MessageLookupByLibrary.simpleMessage("ダークテーマ"),
        "east": MessageLookupByLibrary.simpleMessage("東"),
        "fast": MessageLookupByLibrary.simpleMessage("速い"),
        "goOpen": MessageLookupByLibrary.simpleMessage("開く"),
        "hour": MessageLookupByLibrary.simpleMessage("時間"),
        "kilometer": MessageLookupByLibrary.simpleMessage("km"),
        "kilometerPerHour": MessageLookupByLibrary.simpleMessage("キロメートル/時"),
        "kilometers": MessageLookupByLibrary.simpleMessage("km"),
        "lab": MessageLookupByLibrary.simpleMessage("ラボ"),
        "labelAppDescription": MessageLookupByLibrary.simpleMessage(
            "Material Youのデザイン言語に従ったシンプルな活動トラッキングアプリ。"),
        "labelAvgPace": MessageLookupByLibrary.simpleMessage("平均ペース"),
        "labelPace": MessageLookupByLibrary.simpleMessage("ペース"),
        "labelStep": MessageLookupByLibrary.simpleMessage("歩数"),
        "language": MessageLookupByLibrary.simpleMessage("言語"),
        "lightTheme": MessageLookupByLibrary.simpleMessage("ライトテーマ"),
        "locationServiceDisabled":
            MessageLookupByLibrary.simpleMessage("位置情報サービスが無効です"),
        "maxAltitude": MessageLookupByLibrary.simpleMessage("最高高度"),
        "maxPace": MessageLookupByLibrary.simpleMessage("最大ペース"),
        "meter": MessageLookupByLibrary.simpleMessage("m"),
        "meters": MessageLookupByLibrary.simpleMessage("m"),
        "min": MessageLookupByLibrary.simpleMessage("分"),
        "minAltitude": MessageLookupByLibrary.simpleMessage("最低高度"),
        "minPace": MessageLookupByLibrary.simpleMessage("最小ペース"),
        "minutePerKilometer": MessageLookupByLibrary.simpleMessage("/キロメートル"),
        "month": MessageLookupByLibrary.simpleMessage("月"),
        "newLocationReceived":
            MessageLookupByLibrary.simpleMessage("New location received"),
        "north": MessageLookupByLibrary.simpleMessage("北"),
        "notificationTotalDiatance": m2,
        "pace": MessageLookupByLibrary.simpleMessage("ペース"),
        "recentActivity": MessageLookupByLibrary.simpleMessage("最近の活動"),
        "refuse": MessageLookupByLibrary.simpleMessage("拒否"),
        "settings": MessageLookupByLibrary.simpleMessage("設定"),
        "sky": MessageLookupByLibrary.simpleMessage("空"),
        "slow": MessageLookupByLibrary.simpleMessage("遅い"),
        "toNow": MessageLookupByLibrary.simpleMessage("現在まで"),
        "toastDistanceTooShort":
            MessageLookupByLibrary.simpleMessage("距離が短すぎて、データは記録されません。"),
        "total": MessageLookupByLibrary.simpleMessage("合計"),
        "totalDistance": MessageLookupByLibrary.simpleMessage("総距離"),
        "totalDuration": MessageLookupByLibrary.simpleMessage("総時間"),
        "ttsEndRun": m3,
        "ttsStartRun":
            MessageLookupByLibrary.simpleMessage("走りだそう！ランニングの時間が始まりました。"),
        "unauthorizedLocation":
            MessageLookupByLibrary.simpleMessage("位置情報の許可がありません"),
        "unauthorizedLocationAlways": MessageLookupByLibrary.simpleMessage(
            "アプリがバックグラウンドで実行されている場合にデバイスの位置情報へのアクセスを許可されていません。"),
        "unauthorizedLocationDescription": MessageLookupByLibrary.simpleMessage(
            "屋外での位置情報にアクセスできません。FlyMove - パーミッションに移動して位置情報のアクセスを許可してください。"),
        "unit": m4,
        "unitKm": MessageLookupByLibrary.simpleMessage("km"),
        "unitM": MessageLookupByLibrary.simpleMessage("m"),
        "versionBuild": m5,
        "viewChangelog": MessageLookupByLibrary.simpleMessage("変更履歴を表示"),
        "viewPrivacyPolicy":
            MessageLookupByLibrary.simpleMessage("プライバシーポリシーを表示"),
        "viewReadme": MessageLookupByLibrary.simpleMessage("Readmeを表示"),
        "week": MessageLookupByLibrary.simpleMessage("週"),
        "workoutsTimes": MessageLookupByLibrary.simpleMessage("回"),
        "year": MessageLookupByLibrary.simpleMessage("年")
      };
}
