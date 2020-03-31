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

    final List<String> arr = word.split('');

    for (int i = 0; i < arr.length; i++) {
      final String val = arr[i];
      if (val.toLowerCase() == keyword.toLowerCase()) {
        spans.add(TextSpan(text: val, style: keywordStyle));
      } else {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
