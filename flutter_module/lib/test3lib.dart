import 'package:english_words/english_words.dart';
import 'package:flutter/cupertino.dart';

class RandomWordsWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wordPair = new WordPair.random();
    return Padding (
      padding: const EdgeInsets.all(8),
      child: new Text(wordPair.toString()),
    );
  }
}