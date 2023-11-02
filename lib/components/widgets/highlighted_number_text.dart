import 'package:flutter/material.dart';

class HighlightNumberText extends StatelessWidget {
  final String text;
  final TextStyle? hightlightTextStyle;
  final TextStyle? textStyle;

  const HighlightNumberText(
      {super.key,
      required this.text,
      this.hightlightTextStyle,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    List<TextSpan> textSpans = [];

    RegExp regex = RegExp(r'-?\d+(\.\d+)?');
    Iterable<Match> matches = regex.allMatches(text);

    int currentIndex = 0;
    for (Match match in matches) {
      String matchText = match.group(0)!;
      int startIndex = match.start;
      int endIndex = match.end;

      // 添加非数字部分
      if (currentIndex < startIndex) {
        textSpans.add(TextSpan(
            text: text.substring(currentIndex, startIndex), style: textStyle));
      }

      // 添加高亮数字部分
      textSpans.add(TextSpan(
        text: matchText,
        style: hightlightTextStyle ??
            const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
      ));

      currentIndex = endIndex;
    }

    // 添加剩余的非数字部分
    if (currentIndex < text.length) {
      textSpans
          .add(TextSpan(text: text.substring(currentIndex), style: textStyle));
    }

    return RichText(
      text: TextSpan(
        children: textSpans,
      ),
    );
  }
}
