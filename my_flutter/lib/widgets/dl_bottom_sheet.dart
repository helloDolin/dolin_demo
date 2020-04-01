/*
 * @Author: shaolin 
 * @Date: 2020-04-01 15:16:02 
 * @Last Modified by:   shaolin 
 * @Last Modified time: 2020-04-01 15:16:02 
 */

import 'package:flutter/material.dart';

class DLBottomSheet {
  static void show(BuildContext context,
      {@required List<String> list,
      String title = '',
      Function(int index, String text) onTapCallBack}) {
    assert(list != null && list.length > 1,
        'list must not be null and length should > 1');
    Navigator.push(
        context,
        _BottomSheetRoute(
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            list: list,
            title: title,
            onTapCallBack: onTapCallBack));
  }
}

class _BottomSheetRoute extends PopupRoute {
  _BottomSheetRoute(
      {this.onTapCallBack, this.barrierLabel, this.list, this.title});
  final List<String> list;
  final String title;
  final Function(int index, String text) onTapCallBack;

  @override
  Color get barrierColor => const Color.fromRGBO(0, 0, 0, 0.4);

  @override
  bool get barrierDismissible => true;

  @override
  final String barrierLabel;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final Widget bottomSheet = MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: _BottomSheetWidget(
        route: this,
        list: list,
        title: title,
        onTapCallBack: onTapCallBack,
      ),
    );
    return bottomSheet;
  }

  @override
  Duration get transitionDuration => const Duration(milliseconds: 150);
}

class _BottomSheetWidget extends StatelessWidget {
  const _BottomSheetWidget(
      {@required this.route,
      this.list,
      this.title,
      Key key,
      this.onTapCallBack})
      : super(key: key);
  final _BottomSheetRoute route;
  final List<String> list;
  final String title;
  final Function(int index, String text) onTapCallBack;

  @override
  Widget build(BuildContext context) => GestureDetector(
        excludeFromSemantics: true,
        child: AnimatedBuilder(
          animation: route.animation,
          builder: (context, child) => ClipRect(
            child: CustomSingleChildLayout(
              delegate: _BottomPickerLayout(route.animation.value,
                  contentHeight: MediaQuery.of(context).size.height),
              child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: SafeArea(
                    child: DLBottomSheetWidget(
                      list: list,
                      title: title,
                      onTapCallBack: onTapCallBack,
                    ),
                  )),
            ),
          ),
        ),
      );
}

class _BottomPickerLayout extends SingleChildLayoutDelegate {
  _BottomPickerLayout(this.progress, {this.contentHeight});

  final double progress;
  final double contentHeight;

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      BoxConstraints(
        minWidth: constraints.maxWidth,
        maxWidth: constraints.maxWidth,
        minHeight: 0,
        maxHeight: contentHeight,
      );

  @override
  Offset getPositionForChild(Size size, Size childSize) =>
      Offset(0, size.height - childSize.height * progress);

  @override
  bool shouldRelayout(_BottomPickerLayout oldDelegate) =>
      progress != oldDelegate.progress;
}

/// DLBottomSheetWidget
class DLBottomSheetWidget extends StatefulWidget {
  const DLBottomSheetWidget(
      {Key key, this.list, this.title, this.onTapCallBack})
      : super(key: key);
  final List<String> list;
  final String title;
  final Function(int index, String text) onTapCallBack;

  @override
  _DLBottomSheetWidgetState createState() => _DLBottomSheetWidgetState();
}

class _DLBottomSheetWidgetState extends State<DLBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    final rpx = MediaQuery.of(context).size.width / 375;

    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        child: Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  // 阻断事件冒泡
                  GestureDetector(
                    onTap: () {},
                    child: Offstage(
                        offstage: widget?.title?.isEmpty ?? true,
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.center,
                              width: double.infinity,
                              height: 30,
                              color: Colors.white,
                              child: Text(
                                '${widget?.title ?? ''}',
                                style: TextStyle(
                                    fontSize: 13 * rpx,
                                    color: const Color(0xff666666)),
                              ),
                            ),
                            const _Line(),
                          ],
                        )),
                  ),
                  Column(
                    children: _items(),
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: const Color(0xffE6E6E6),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 60,
                    color: Colors.white,
                    child: Text(
                      '取消',
                      style: TextStyle(
                          fontSize: 15 * rpx, color: const Color(0xff333333)),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }

  List<Widget> _items() {
    final arr = <Widget>[];
    for (var i = 0; i < widget.list.length; i++) {
      final text = widget.list[i];
      arr.add(_Item(
        text: text,
        index: i,
        onTapCallBack: widget?.onTapCallBack,
        isHideLine: i == widget.list.length - 1,
      ));
    }
    return arr;
  }
}

/// 分割线
class _Line extends StatelessWidget {
  const _Line({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final rpx = MediaQuery.of(context).size.width / 375;

    return Container(
      color: Colors.white,
      child: Container(
        color: const Color(0xffE6E6E6),
        height: 0.5,
        margin: EdgeInsets.symmetric(horizontal: 10 * rpx),
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(
      {Key key,
      this.text,
      this.onTapCallBack,
      this.index,
      this.isHideLine = false})
      : super(key: key);
  final String text;
  final int index;
  final Function(int index, String text) onTapCallBack;
  final bool isHideLine;

  @override
  Widget build(BuildContext context) {
    final rpx = MediaQuery.of(context).size.width / 375;

    return GestureDetector(
      onTap: () {
        if (onTapCallBack != null) {
          onTapCallBack(index, text);
        }
        Navigator.pop(context);
      },
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16 * rpx),
            alignment: Alignment.center,
            color: Colors.white,
            width: double.infinity,
            height: 60,
            child: Text(
              '${text ?? ''}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(fontSize: 15 * rpx, color: const Color(0xff333333)),
            ),
          ),
          Offstage(
            offstage: isHideLine,
            child: const _Line(),
          ),
        ],
      ),
    );
  }
}
