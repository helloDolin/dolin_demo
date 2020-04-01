import 'package:flutter/material.dart';
import 'package:my_flutter/pages/block_chain_analyze/page.dart';
import 'package:my_flutter/pages/dl_alert_page.dart';
import 'package:my_flutter/pages/dl_badge_page.dart';
import 'package:my_flutter/pages/dl_bubble_page.dart';
import 'package:my_flutter/pages/dl_button_page.dart';
import 'package:my_flutter/pages/dl_timeline_item_page.dart';
import 'package:my_flutter/pages/gesture_study.dart';
import 'package:my_flutter/pages/hero_test.dart';
import 'package:my_flutter/pages/index.dart';
import 'package:my_flutter/pages/noti_study.dart';
import 'package:my_flutter/pages/dl_search_bar_page.dart';
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
        'hero_test': (context) => const HeroTestPage(),
        'gesture_study': (context) => const GestureStudyPage(),
        'sliver_study': (context) => const SliverStudyPage(),
        'noti_study': (context) => const NotiStudyPage(),
        'block_chain_analyze': (context) => Page(),
        'dl_bubble_page': (context) => const DLBubblePage(),
        'dl_search_bar_page': (context) {
          return SearchBarPage(
            defaultSearchWord: ModalRoute.of(context).settings.arguments,
          );
        },
        'dl_button_page': (context) => const DLButtonPage(),
        'dl_alert_page': (context) => const DLAlertPage(),
        'dl_badge_page': (context) => const DLBadgePage(),
        'dl_timeline_item_page': (context) => const DLTimelineItemPage(),
      },
      onUnknownRoute: (RouteSettings setting) =>
          MaterialPageRoute(builder: (context) => const UnKnowPage()),
    );
  }
}
