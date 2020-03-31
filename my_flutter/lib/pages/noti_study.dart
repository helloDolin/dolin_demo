import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';

class NotiStudyPage extends StatefulWidget {
  const NotiStudyPage({Key key}) : super(key: key);

  @override
  _NotiStudyPageState createState() => _NotiStudyPageState();
}

class _NotiStudyPageState extends State<NotiStudyPage> {
  String _msg = '通知：';

  @override
  Widget build(BuildContext context) {
    return NotificationListener<CustomNotification>(
        onNotification: (noti) {
          setState(() {
            _msg += '${noti.msg} ';
          });
          return true;
        },
        child: Scaffold(
          appBar: DLAppBar(
            'NotiStudyPage',
            onTapBackBtn: () {
              Navigator.pop(context);
            },
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(_msg),
            ],
          ),
          bottomNavigationBar: CustomChild(),
        ));
  }
}

class CustomNotification extends Notification {
  CustomNotification(this.msg);
  final String msg;
}

// 抽离出一个子 Widget 用来发通知
class CustomChild extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: RaisedButton(
      onPressed: () => CustomNotification('hello').dispatch(context),
      child: const Text('Fire Notification'),
    ));
  }
}
