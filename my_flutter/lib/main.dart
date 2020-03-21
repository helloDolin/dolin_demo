import 'package:flutter/material.dart';
import 'package:my_flutter/pages/dl_bubble.dart';
import 'package:my_flutter/pages/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'just for fun',
      initialRoute: '/',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.greenAccent, // Toolbar、Tabbar 背景色
        scaffoldBackgroundColor: Colors.white, // scaffold 背景色
      ),
      routes: {
        '/': (context) => const IndexPage(),
        'dl_bubble': (context) => const DLBubblePage(),
      },
    );
  }
}
