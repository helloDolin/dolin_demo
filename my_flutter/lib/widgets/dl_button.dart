/*
 * @Author: shaolin 
 * @Date: 2020-04-01 10:24:45 
 * @Last Modified by: shaolin
 * @Last Modified time: 2020-04-01 10:42:30
 */

import 'package:flutter/material.dart';

/// button 样式封装
class DLButtonStyle {
  const DLButtonStyle(
      {this.textColor,
      this.pressColor,
      this.pressTextColor,
      this.bgColor,
      this.disabledTextColor = const Color(0xFFFFFFFF),
      this.disabledColor = const Color(0xffcccccc),
      this.borderColor = const Color(0x00000000),
      this.borderPressColor = const Color(0x00000000),
      this.borderDisableColor = const Color(0x00000000)});

  /// 字体颜色
  final Color textColor;

  /// 点击状态的背景颜色
  final Color pressColor;

  /// 背景颜色
  final Color bgColor;

  /// 点击状态的字体颜色
  final Color pressTextColor;

  /// 禁用状态的字体颜色
  final Color disabledTextColor;

  /// 禁用 状态的背景颜色
  final Color disabledColor;

  /// 外框颜色
  final Color borderColor;

  /// 点击状态的外框颜色
  final Color borderPressColor;

  /// 禁用状态的外框颜色
  final Color borderDisableColor;
}

mixin ProtectClickItem {
  static int time = 0;
  static int interval = 500;

  bool isInvalidClick() {
    final curTime = DateTime.now().millisecondsSinceEpoch;
    final intervalTime = curTime - time;
    time = curTime;
    print('intervalTime=$intervalTime');
    return intervalTime < interval;
  }
}

class DLButton extends StatefulWidget {
  const DLButton(
    this.text, {
    @required this.buttonStyle,
    @required this.onPressed,
    Key key,
    this.width,
    this.height = 40.0,
    this.subText,
    this.subTextSize = 12.00,
    this.radius = 4.00,
    this.padding,
    this.textSize = 16.00,
    this.icon,
    this.iconPadding = 10,
    this.disabled = false,
  })  : assert(text != null, 'text must be not null'),
        assert(buttonStyle != null, 'buttonStyle must be not null'),
        assert(onPressed != null, 'onPressed must be not null'),
        super(key: key);

  /// 按钮文本
  final String text;

  /// 按钮子文本
  final String subText;

  /// 按钮文本大小
  final double textSize;

  /// 按钮子文本大小
  final double subTextSize;

  /// 按钮样式
  final DLButtonStyle buttonStyle;

  final double radius;

  final double width;

  final double height;

  final VoidCallback onPressed;

  /// 内边距
  final EdgeInsetsGeometry padding;

  final Widget icon;

  /// icon 距文本左侧边距
  final double iconPadding;

  /// 是否可点击（true：不可点）
  final bool disabled;

  @override
  _DLButtonState createState() => _DLButtonState();
}

class _DLButtonState extends State<DLButton> with ProtectClickItem {
  Color fontColor;
  Color borderColor;

  @override
  Widget build(BuildContext context) => Container(
      width: widget.width,
      height: widget.height,
      child: RaisedButton(
          onPressed: widget.disabled == true
              ? null
              : () {
                  if (isInvalidClick()) {
                    return;
                  }
                  widget.onPressed();
                },
          textColor: widget.buttonStyle.textColor,
          onHighlightChanged: _onPressChange,
          textTheme: ButtonTextTheme.normal,
          shape: RoundedRectangleBorder(
              side: BorderSide(width: 0.5, color: borderColor),
              borderRadius: BorderRadius.all(Radius.circular(widget.radius))),
          highlightColor: widget.buttonStyle.pressColor,
          splashColor: widget.buttonStyle.pressColor,
          colorBrightness: Brightness.light,
          elevation: 1,
          disabledTextColor: widget.buttonStyle.disabledTextColor,
          disabledColor: widget.buttonStyle.disabledColor,
          color: widget.buttonStyle.bgColor,
          padding: widget.padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Offstage(
                offstage: widget.icon == null,
                child: Padding(
                    padding: EdgeInsets.only(right: widget.iconPadding ?? 6),
                    child: widget.icon),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Text>[
                  Text(widget.text ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: fontColor,
                          fontSize: widget.textSize)),
                  Text(widget.subText ?? '',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: fontColor,
                          fontSize: widget.subTextSize))
                ]
                    .map((text) => Offstage(
                          offstage: text?.data?.isEmpty ?? true,
                          child: text,
                        ))
                    .toList(),
              )
            ],
          )));

  @override
  void initState() {
    super.initState();
    fontColor = widget.disabled
        ? widget.buttonStyle.disabledTextColor
        : widget.buttonStyle.textColor;
    borderColor = widget.disabled
        ? widget.buttonStyle.borderDisableColor
        : widget.buttonStyle.borderColor;
  }

  void _onPressChange(bool isPress) {
    if (mounted) {
      setState(() {
        fontColor = widget.disabled
            ? widget.buttonStyle.disabledTextColor
            : isPress
                ? widget.buttonStyle.pressTextColor
                : widget.buttonStyle.textColor;
        borderColor = widget.disabled
            ? widget.buttonStyle.borderDisableColor
            : isPress
                ? widget.buttonStyle.borderPressColor
                : widget.buttonStyle.borderColor;
      });
    }
  }
}

/// 主按钮样式
const DLButtonStyle _mainButtonStyle = DLButtonStyle(
  bgColor: Color(0xFF0B82F1),
  pressColor: Color(0xFF006BCF),
  disabledColor: Color(0xFFCCCCCC),
  textColor: Colors.white,
  pressTextColor: Colors.white,
  disabledTextColor: Colors.white,
);

/// 副按钮样式
const DLButtonStyle _subButtonStyle = DLButtonStyle(
    bgColor: Colors.white,
    pressColor: Colors.white,
    disabledColor: Colors.white,
    textColor: Color(0xFF0B82F1),
    pressTextColor: Color(0xFF0868C0),
    disabledTextColor: Color(0xFFCCCCCC),
    borderColor: Color(0xFF0B82F1),
    borderPressColor: Color(0xFF0B82F1),
    borderDisableColor: Color(0xFFCCCCCC));

/// 主按钮
class DLMainButton extends DLButton {
  const DLMainButton(String text,
      {@required VoidCallback onPressed,
      double width,
      double height = 40.0,
      EdgeInsetsGeometry padding,
      textSize = 16.00,
      radius = 8.00,
      subText = '',
      Widget icon,
      double iconPadding,
      subTextSize = 12.00,
      bool disabled = false})
      : super(text,
            onPressed: onPressed,
            textSize: textSize,
            radius: radius,
            subTextSize: subTextSize,
            subText: subText,
            width: width,
            height: height,
            padding: padding,
            icon: icon,
            iconPadding: iconPadding,
            buttonStyle: _mainButtonStyle,
            disabled: disabled);
}

/// 次按钮
class DLSubButton extends DLButton {
  const DLSubButton(String text,
      {@required VoidCallback onPressed,
      double width,
      double height = 40.0,
      EdgeInsetsGeometry padding,
      textSize = 16.00,
      radius = 8.00,
      subText = '',
      subTextSize = 12.00,
      Widget icon,
      double iconPadding,
      bool disabled = false})
      : super(text,
            onPressed: onPressed,
            textSize: textSize,
            width: width,
            height: height,
            radius: radius,
            subTextSize: subTextSize,
            padding: padding,
            subText: subText,
            icon: icon,
            iconPadding: iconPadding,
            buttonStyle: _subButtonStyle,
            disabled: disabled);
}

/// 左右 Widget 容器（不仅仅服务于button，放这边其实是不合理的）
class HLDoubleWidgetContainer extends StatelessWidget {
  const HLDoubleWidgetContainer(
      {@required this.leftWidget,
      @required this.rightWidget,
      Key key,
      this.width = double.infinity,
      this.height = 40.0,
      this.padding = 9.0,
      this.backgroundColor = Colors.white})
      : super(key: key);
  final Widget leftWidget;
  final Widget rightWidget;
  final double width;
  final double height;
  final Color backgroundColor;
  // 左右 widget 间距
  final double padding;

  @override
  Widget build(BuildContext context) {
    final rpx = MediaQuery.of(context).size.width / 375;
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 16 * rpx),
      height: height,
      width: width,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: leftWidget,
          ),
          SizedBox(width: padding * rpx),
          Expanded(
            flex: 1,
            child: rightWidget,
          ),
        ],
      ),
    );
  }
}
