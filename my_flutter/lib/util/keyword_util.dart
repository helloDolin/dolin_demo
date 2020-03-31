import 'package:flutter/material.dart';

class KeywordUtil {
  static List<TextSpan> keywordTextSpans(String word, String keyword,
      {TextStyle normalStyle, TextStyle keywordStyle}) {
    final List<TextSpan> spans = [];
    if (word == null || word.isEmpty) {
      return spans;
    }
    // 忽略大小写
    final wordL = word.toLowerCase();
    final keywordL = keyword.toLowerCase();
    final List<String> arr = wordL.split(keywordL);
    int preIndex = 0;
    for (int i = 0; i < arr.length; i++) {
      if (i != 0) {
        preIndex = wordL.indexOf(keywordL, preIndex);
        spans.add(TextSpan(
            text: word.substring(preIndex, preIndex + keyword.length),
            style: keywordStyle));
      }
      final String val = arr[i];
      if (val != null && val.isNotEmpty) {
        spans.add(TextSpan(text: val, style: normalStyle));
      }
    }
    return spans;
  }
}
