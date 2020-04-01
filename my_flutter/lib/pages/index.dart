import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';
import 'package:my_flutter/widgets/dl_bottom_sheet.dart';
import 'package:my_flutter/widgets/dl_button.dart';
import 'package:my_flutter/widgets/simple_btn.dart';
import 'package:dl_plugin/dl_plugin.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({Key key}) : super(key: key);

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DLAppBar(
          'dolin demo',
          isHideBackBtn: false,
          onTapBackBtn: () async {
            final result = await DlPlugin.dismissCurrentVC;
            print(result);
          },
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SimpleBtn(
                  title: 'dl_bubble_page',
                  tap: () {
                    Navigator.pushNamed(context, 'dl_bubble_page');
                  },
                ),
                SimpleBtn(
                  title: 'dl_search_bar_page',
                  tap: () {
                    Navigator.pushNamed(context, 'dl_search_bar_page');
                  },
                ),
                SimpleBtn(
                  title: 'dl_button_page',
                  tap: () {
                    Navigator.pushNamed(context, 'dl_button_page');
                  },
                ),
                SimpleBtn(
                  title: 'dl_alert_page',
                  tap: () {
                    Navigator.pushNamed(context, 'dl_alert_page');
                  },
                ),
                SimpleBtn(
                  title: 'dl_badge_page',
                  tap: () {
                    Navigator.pushNamed(context, 'dl_badge_page');
                  },
                ),
                SimpleBtn(
                  title: 'dl_timeline_item_page',
                  tap: () {
                    Navigator.pushNamed(context, 'dl_timeline_item_page');
                  },
                ),
                SimpleBtn(
                  title: 'gesture_study',
                  tap: () {
                    Navigator.pushNamed(context, 'gesture_study');
                  },
                ),
                SimpleBtn(
                  title: 'sliver_study',
                  tap: () {
                    Navigator.pushNamed(context, 'sliver_study');
                  },
                ),
                SimpleBtn(
                  title: 'noti_study',
                  tap: () {
                    Navigator.pushNamed(context, 'noti_study');
                  },
                ),
                SimpleBtn(
                  title: 'block_chain_analyze',
                  tap: () {
                    Navigator.pushNamed(context, 'block_chain_analyze');
                  },
                ),
                SimpleBtn(
                  title: '未注册的路由',
                  subTitle: 'unknowroute',
                  tap: () {
                    Navigator.pushNamed(context, 'unknowroute');
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, 'hero_test');
                  },
                  child: Hero(
                    tag: 'hero_test',
                    child: Container(
                      width: 50,
                      height: 50,
                      child: const FlutterLogo(),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          child: DLMainButton('bottom sheet', radius: 0.0, onPressed: () {
            DLBottomSheet.show(context, list: ['1', '2', '3'], title: '123',
                onTapCallBack: (index, str) {
              print('$index -- $str');
            });
          }),
        ));
  }
}
