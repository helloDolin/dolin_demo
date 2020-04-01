import 'package:flutter/material.dart';

class KeywordUtil {
  static List<TextSpan> keywordTextSpans(
    String word,
    String keyword, {
    TextStyle normalStyle = const TextStyle(fontSize: 14, color: Colors.black),
    TextStyle keywordStyle = const TextStyle(fontSize: 14, color: Colors.red),
  }) {
    final List<TextSpan> spans = [];

    if (word == null || word.isEmpty) {
      return spans;
    }

    if (keyword.isEmpty) {
      spans.add(TextSpan(text: word, style: normalStyle));
      return spans;
    }

    final List<String> arr = word.split(keyword);
    print(arr);

    // 拼装 spans
    for (var i = 0; i < arr.length; i++) {
      if (i != 0) {
        spans.add(TextSpan(text: keyword, style: keywordStyle));
      }
      final String obj = arr[i];
      if (obj.isNotEmpty) {
        spans.add(TextSpan(text: obj, style: normalStyle));
      }
    }
    return spans;
  }
}
