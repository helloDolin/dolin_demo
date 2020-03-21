library dl_bubble;

import 'package:flutter/material.dart';

/// 三角位置
enum DLTrianglePosition {
  leftTop,
  leftBottom,
  rightTop,
  rightBottom,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight
}

/// 气泡 widget
///
/// TODO: horizontalTriangle、verticalTriangle 设计
class DLBubble extends StatelessWidget {
  const DLBubble({
    @required this.child,
    @required this.trianglePosition,
    this.trianglePadding = 10.0,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    this.color = const Color.fromRGBO(0, 0, 0, 0.8),
    this.radius = 4,
    this.horizontalTriangleWidth = 12.0,
    this.horizontalTriangleHeight = 5.0,
    this.verticalTriangleWidth = 5.0,
    this.verticalTriangleHeight = 12.0,
    Key key,
  })  : assert(child != null, 'child must not be null'),
        assert(trianglePosition != null, 'bubblePosition must not be null'),
        super(key: key);

  /// 三角 padding
  ///
  /// trianglePosition 为左上即为离左上的padding
  ///
  /// trianglePosition 为左下即为离左下的padding
  ///
  /// 以此类推
  final double trianglePadding;

  final EdgeInsets padding;
  final Widget child;
  final Color color;

  /// 三角位置
  final DLTrianglePosition trianglePosition;

  /// 气泡圆角
  final double radius;

  /// 水平三角宽
  final double horizontalTriangleWidth;

  /// 水平三角高
  final double horizontalTriangleHeight;

  /// 垂直三角宽
  final double verticalTriangleWidth;

  /// 垂直三角高
  final double verticalTriangleHeight;

  EdgeInsets get _padding {
    switch (trianglePosition) {
      case DLTrianglePosition.leftTop:
      case DLTrianglePosition.leftBottom:
        return EdgeInsets.only(left: verticalTriangleWidth);
        break;
      case DLTrianglePosition.rightTop:
      case DLTrianglePosition.rightBottom:
        return EdgeInsets.only(right: verticalTriangleWidth);
        break;
      case DLTrianglePosition.topLeft:
      case DLTrianglePosition.topRight:
        return EdgeInsets.only(top: horizontalTriangleHeight);
        break;
      case DLTrianglePosition.bottomLeft:
      case DLTrianglePosition.bottomRight:
        return EdgeInsets.only(bottom: horizontalTriangleHeight);
        break;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return PhysicalShape(
      clipper: BubbleClipper(
          horizontalTriangleHeight: horizontalTriangleHeight,
          horizontalTriangleWidth: horizontalTriangleWidth,
          verticalTriangleHeight: verticalTriangleHeight,
          verticalTriangleWidth: verticalTriangleWidth,
          trianglePadding: trianglePadding,
          bubblePosition: trianglePosition,
          rpx: 1,
          radius: radius),
      color: color,
      child: Container(
        padding: EdgeInsets.only(
            left: padding.left + _padding.left,
            right: padding.right + _padding.right,
            top: padding.top + _padding.top,
            bottom: padding.bottom + _padding.bottom),
        child: child,
      ),
    );
  }
}

class BubbleClipper extends CustomClipper<Path> {
  BubbleClipper({
    this.rpx,
    this.trianglePadding,
    this.bubblePosition,
    this.radius,
    this.horizontalTriangleWidth,
    this.horizontalTriangleHeight,
    this.verticalTriangleWidth,
    this.verticalTriangleHeight,
  });

  final DLTrianglePosition bubblePosition;
  final double rpx;
  final double radius;
  final double trianglePadding;
  final double horizontalTriangleWidth;
  final double horizontalTriangleHeight;
  final double verticalTriangleWidth;
  final double verticalTriangleHeight;

  @override
  Path getClip(Size size) {
    final path = Path();
    final padding = trianglePadding * rpx;

    switch (bubblePosition) {
      case DLTrianglePosition.leftTop:
        path.addRRect(RRect.fromLTRBR(verticalTriangleWidth, 0, size.width,
            size.height, Radius.circular(radius * rpx)));
        path.moveTo(0, padding + verticalTriangleHeight / 2);
        path.lineTo(verticalTriangleWidth, padding);
        path.lineTo(verticalTriangleWidth, padding + verticalTriangleHeight);
        path.close();
        break;
      case DLTrianglePosition.leftBottom:
        path.addRRect(RRect.fromLTRBR(verticalTriangleWidth, 0, size.width,
            size.height, Radius.circular(radius * rpx)));
        path.moveTo(0, size.height - padding - verticalTriangleHeight / 2);
        path.lineTo(verticalTriangleWidth,
            size.height - padding - verticalTriangleHeight);
        path.lineTo(verticalTriangleWidth, size.height - padding);
        path.close();
        break;
      case DLTrianglePosition.rightTop:
        path.addRRect(RRect.fromLTRBR(0, 0, size.width - verticalTriangleWidth,
            size.height, Radius.circular(radius * rpx)));
        path.moveTo(size.width, padding + verticalTriangleHeight / 2);
        path.lineTo(size.width - verticalTriangleWidth, padding);
        path.lineTo(size.width - verticalTriangleWidth,
            padding + verticalTriangleHeight);
        path.close();
        break;
      case DLTrianglePosition.rightBottom:
        path.addRRect(RRect.fromLTRBR(0, 0, size.width - verticalTriangleWidth,
            size.height, Radius.circular(radius * rpx)));
        path.moveTo(
            size.width, size.height - padding - verticalTriangleHeight / 2);
        path.lineTo(size.width - verticalTriangleWidth, size.height - padding);
        path.lineTo(size.width - verticalTriangleWidth,
            size.height - padding - verticalTriangleHeight);
        path.close();
        break;
      case DLTrianglePosition.topLeft:
        path.addRRect(RRect.fromLTRBR(0, horizontalTriangleHeight, size.width,
            size.height, Radius.circular(radius * rpx)));
        path.moveTo(padding + horizontalTriangleWidth / 2, 0);
        path.lineTo(padding, horizontalTriangleHeight);
        path.lineTo(
            padding + horizontalTriangleWidth, horizontalTriangleHeight);
        path.close();
        break;
      case DLTrianglePosition.topRight:
        path.addRRect(RRect.fromLTRBR(0, horizontalTriangleHeight, size.width,
            size.height, Radius.circular(radius * rpx)));
        path.moveTo(size.width - padding - horizontalTriangleWidth / 2, 0);
        path.lineTo(size.width - padding, horizontalTriangleHeight);
        path.lineTo(size.width - padding - horizontalTriangleWidth,
            horizontalTriangleHeight);
        path.close();
        break;
      case DLTrianglePosition.bottomLeft:
        path.addRRect(RRect.fromLTRBR(
            0,
            0,
            size.width,
            size.height - horizontalTriangleHeight,
            Radius.circular(radius * rpx)));
        path.moveTo(padding + horizontalTriangleWidth / 2, size.height);
        path.lineTo(padding, size.height - horizontalTriangleHeight);
        path.lineTo(padding + horizontalTriangleWidth,
            size.height - horizontalTriangleHeight);
        path.close();
        break;
      case DLTrianglePosition.bottomRight:
        path.addRRect(RRect.fromLTRBR(
            0,
            0,
            size.width,
            size.height - horizontalTriangleHeight,
            Radius.circular(radius * rpx)));
        path.moveTo(
            size.width - padding - horizontalTriangleWidth / 2, size.height);
        path.lineTo(
            size.width - padding, size.height - horizontalTriangleHeight);
        path.lineTo(size.width - padding - horizontalTriangleWidth,
            size.height - horizontalTriangleHeight);
        path.close();
        break;
    }
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
