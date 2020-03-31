import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';

class GestureStudyPage extends StatefulWidget {
  const GestureStudyPage({Key key}) : super(key: key);

  @override
  _GestureStudyPageState createState() => _GestureStudyPageState();
}

class _GestureStudyPageState extends State<GestureStudyPage> {
  double _top = 0;
  double _left = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DLAppBar(
        'GestureStudyPage',
        onTapBackBtn: () {
          Navigator.pop(context);
        },
      ),
      body: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 300,
            child: Stack(
              children: <Widget>[
                Positioned(
                    top: _top,
                    left: _left,
                    child: GestureDetector(
                      onTap: () => print('Tap'), // 点击回调
                      onDoubleTap: () => print('Double Tap'), // 双击回调
                      onLongPress: () => print('Long Press'), // 长按回调
                      onPanUpdate: (e) {
                        // 拖动回调
                        setState(() {
                          // 更新位置
                          _left += e.delta.dx;
                          _top += e.delta.dy;
                        });
                      },
                      child: Container(
                        color: Colors.red,
                        width: 100,
                        height: 100,
                      ),
                    ))
              ],
            ),
          ),
          RawGestureDetector(
            gestures: {
              // 建立多手势识别器与手势识别工厂类的映射关系，从而返回可以响应该手势的 recognizer
              MultipleTapGestureRecognizer:
                  GestureRecognizerFactoryWithHandlers<
                      MultipleTapGestureRecognizer>(
                () => MultipleTapGestureRecognizer(),
                (MultipleTapGestureRecognizer instance) {
                  instance.onTap = () => print('parent tapped '); // 点击回调
                },
              )
            },
            child: Container(
              color: Colors.pinkAccent,
              child: Center(
                child: GestureDetector(
                  onTap: () => print('Child tapped'), // 子视图的点击回调
                  child: Container(
                    color: Colors.blueAccent,
                    width: 200,
                    height: 200,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MultipleTapGestureRecognizer extends TapGestureRecognizer {
  @override
  void rejectGesture(int pointer) {
    acceptGesture(pointer);
  }
}
