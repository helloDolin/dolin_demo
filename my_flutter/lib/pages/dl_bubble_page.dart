import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';
import 'package:dl_bubble/dl_bubble.dart';

class DLBubblePage extends StatefulWidget {
  const DLBubblePage({Key key}) : super(key: key);

  @override
  _DLBubblePageState createState() => _DLBubblePageState();
}

class _DLBubblePageState extends State<DLBubblePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DLAppBar('DLBubblePage', onTapBackBtn: () {
          Navigator.pop(context);
        }),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DLBubble(
              trianglePosition: DLTrianglePosition.leftTop,
              color: Colors.blue,
              child: Text(
                'dolin  dolin ',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            DLBubble(
              trianglePosition: DLTrianglePosition.leftBottom,
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
            DLBubble(
              trianglePosition: DLTrianglePosition.rightTop,
              child: Text(
                'dolin dolin ',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            DLBubble(
              trianglePosition: DLTrianglePosition.rightBottom,
              child: Text(
                'dolin  dolin ',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            DLBubble(
              trianglePosition: DLTrianglePosition.topLeft,
              child: Text(
                'dolin  dolin ',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            DLBubble(
              trianglePosition: DLTrianglePosition.topRight,
              child: Text(
                'dolin  dolin ',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            DLBubble(
              trianglePosition: DLTrianglePosition.bottomLeft,
              child: Text(
                'dolin  dolin ',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
            DLBubble(
              trianglePosition: DLTrianglePosition.bottomRight,
              child: Text(
                'dolin  dolin ',
                style: TextStyle(color: Colors.white, fontSize: 30),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ))));
  }
}
