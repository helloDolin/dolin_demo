import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';
import 'package:my_flutter/widgets/dl_badge.dart';

class DLBadgePage extends StatefulWidget {
  const DLBadgePage({Key key}) : super(key: key);

  @override
  _DLBadgePageState createState() => _DLBadgePageState();
}

class _DLBadgePageState extends State<DLBadgePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DLAppBar(
        'DLBadgePage',
        onTapBackBtn: () {
          Navigator.pop(context);
        },
      ),
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
        child: Wrap(
          spacing: 30,
          runSpacing: 20,
          children: <Widget>[
            DLBadge(
              text: '1',
              textStyle: const TextStyle(fontSize: 18, color: Colors.white),
              badgeTextPadding: const EdgeInsets.all(10),
              positionedRight: -15,
              positionedTop: -20,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.black,
              ),
            ),
            DLBadge(
              number: 18,
              child: Container(
                width: 50,
                height: 50,
                color: Colors.black,
              ),
            ),
            DLBadge(
              number: 100,
              child: Container(
                width: 100,
                height: 100,
                color: Colors.black,
              ),
            ),
            DLBadge(
              text: '利口酒',
              child: Container(
                width: 100,
                height: 100,
                color: Colors.black,
              ),
            ),
            DLBadge(
              text: '',
              child: Container(
                width: 60,
                height: 60,
                color: Colors.black,
              ),
            ),
          ],
        ),
      )),
    );
  }
}
