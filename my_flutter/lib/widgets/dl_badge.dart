/*
 * @Author: shaolin 
 * @Date: 2020-04-01 14:36:29 
 * @Last Modified by: shaolin
 * @Last Modified time: 2020-04-01 14:45:42
 */

import 'package:flutter/material.dart';

class DLBadge extends StatelessWidget {
  const DLBadge({
    @required this.child,
    Key key,
    this.text = '',
    this.number,
    this.textStyle = const TextStyle(color: Colors.white, fontSize: 10),
    this.bgColor = Colors.red,
    this.borderRadius = 100.0,
    this.isHideBadge = false,
    this.positionedRight = -10.0,
    this.positionedTop = -10.0,
    this.badgeTextPadding =
        const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
  })  : assert(child != null, 'child must not be null'),
        super(key: key);

  final Widget child;

  final String text;

  final int number;

  final TextStyle textStyle;

  final Color bgColor;

  final double borderRadius;

  final bool isHideBadge;

  /// 离 Stack 右侧距离
  final double positionedRight;

  /// 离 Stack 上侧距离
  final double positionedTop;

  /// badge 文本间距
  final EdgeInsetsGeometry badgeTextPadding;

  @override
  Widget build(BuildContext context) => Stack(
        overflow: Overflow.visible,
        children: <Widget>[
          child,
          Positioned(
              right: positionedRight,
              top: positionedRight,
              child: Offstage(
                offstage: isHideBadge,
                child: Container(
                  alignment: Alignment.center,
                  padding: badgeTextPadding,
                  decoration: BoxDecoration(
                    color: bgColor,
                    shape: _badgeShape,
                    borderRadius: _badgeRadius,
                  ),
                  child: Text(
                    _badgeText,
                    style: textStyle,
                  ),
                ),
              ))
        ],
      );

  String get _badgeText {
    if (number != null) {
      if (number <= 0) {
        return '';
      } else {
        if (number > 99) {
          return '99+';
        } else {
          return number.toString();
        }
      }
    }
    return text;
  }

  BoxShape get _badgeShape {
    if (borderRadius == 100 && _badgeText.length <= 1) {
      return BoxShape.circle;
    } else {
      return BoxShape.rectangle;
    }
  }

  BorderRadius get _badgeRadius {
    if (_badgeShape == BoxShape.circle) {
      return null;
    } else {
      return BorderRadius.circular(borderRadius);
    }
  }
}
