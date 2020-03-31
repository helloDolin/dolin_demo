import 'package:flutter/material.dart';
import 'package:my_flutter/pages/block_chain_analyze/page.dart';
import 'package:my_flutter/pages/dl_bubble.dart';
import 'package:my_flutter/pages/gesture_study.dart';
import 'package:my_flutter/pages/hero_test.dart';
import 'package:my_flutter/pages/index.dart';
import 'package:my_flutter/pages/noti_study.dart';
import 'package:my_flutter/pages/search_bar.dart';
import 'package:my_flutter/pages/sliver_study.dart';
import 'package:my_flutter/pages/un_know_page.dart';

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
        'hero_test': (context) => const HeroTestPage(),
        'gesture_study': (context) => const GestureStudyPage(),
        'sliver_study': (context) => const SliverStudyPage(),
        'noti_study': (context) => const NotiStudyPage(),
        'block_chain_analyze': (context) => Page(),
        'search_bar': (context) => const SearchBarPage(),
      },
      onUnknownRoute: (RouteSettings setting) =>
          MaterialPageRoute(builder: (context) => const UnKnowPage()),
    );
  }
}
