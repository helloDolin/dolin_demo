import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';
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
          'dolin widgets',
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
                  title: 'dl_bubble',
                  tap: () {
                    Navigator.pushNamed(context, 'dl_bubble');
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
                  title: '错误路由',
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
        ));
  }
}
