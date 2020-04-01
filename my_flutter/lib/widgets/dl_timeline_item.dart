/*
 * @Author: shaolin 
 * @Date: 2020-04-01 15:23:29 
 * @Last Modified by: shaolin
 * @Last Modified time: 2020-04-01 15:23:59
 */

import 'package:flutter/material.dart';

/// 实线、虚线
enum DLTimelineType { solid, dot }

class DLTimelineItem extends StatelessWidget {
  const DLTimelineItem(
      {@required this.child,
      Key key,
      this.timeLineType = DLTimelineType.solid,
      this.timelineColor = const Color(0xffD8D8D8),
      this.isFirst = false,
      this.isEnd = false,
      this.nodeWidget,
      this.nodeColor = const Color(0xffD8D8D8),
      this.nodeWidth = 9.0,
      this.nodeTopPadding = 0.0})
      : assert(child != null, '子 widget 不能为空'),
        super(key: key);

  /// 时间轴类型
  final DLTimelineType timeLineType;

  /// 时间轴颜色
  final Color timelineColor;

  /// 子 widget
  final Widget child;

  /// 是否是第一个节点
  final bool isFirst;

  /// 是否是最后一个节点
  final bool isEnd;

  /// 节点 widget
  final Widget nodeWidget;

  /// 节点颜色
  final Color nodeColor;

  /// 节点宽
  final double nodeWidth;

  /// 节点上边距
  final double nodeTopPadding;

  @override
  Widget build(BuildContext context) {
    final rpx = MediaQuery.of(context).size.width / 375;

    // 自定义绘制容器宽度（按蓝湖宽度）
    final paintContainerWidth = 42 * rpx;

    // 圆形节点
    Widget icon = Container(
      width: nodeWidth,
      height: nodeWidth,
      decoration: BoxDecoration(
        color: nodeColor,
        borderRadius: BorderRadius.all(Radius.circular(nodeWidth / 2)),
      ),
    );

    // 自定义节点
    if (nodeWidget != null) {
      icon = nodeWidget;
    }

    return IntrinsicHeight(
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: paintContainerWidth,
                height: double.infinity,
                child: CustomPaint(
                  painter: _TimeLinePainter(
                      lineColor: timelineColor,
                      type: timeLineType,
                      beginY: isFirst || isEnd ? nodeTopPadding : 0.0,
                      isFirst: isFirst),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: nodeTopPadding),
                constraints: BoxConstraints(
                  maxWidth: paintContainerWidth,
                ),
                height: double.infinity,
                alignment: Alignment.topCenter,
                child: icon,
              )
            ],
          ),
          Expanded(
            flex: 1,
            child: child,
          )
        ],
      ),
    );
  }
}

/// 自定义绘制
class _TimeLinePainter extends CustomPainter {
  _TimeLinePainter(
      {this.lineColor, this.type, this.beginY = 0.0, this.isFirst = false});
  final Color lineColor;
  final DLTimelineType type;
  final double beginY;
  final bool isFirst;

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 1;
    switch (type) {
      case DLTimelineType.solid:
        canvas.drawLine(Offset(size.width / 2, isFirst ? 0.0 : beginY),
            Offset(size.width / 2, isFirst ? beginY : size.height), linePaint);
        break;
      case DLTimelineType.dot:
        var startY = isFirst ? 0.0 : beginY;
        const dashHeight = 5.0;
        const dashSpace = 5.0;
        const space = dashHeight + dashSpace;
        final max = isFirst ? beginY : size.height;
        while (startY < max) {
          canvas.drawLine(Offset(size.width / 2, startY),
              Offset(size.width / 2, startY + dashHeight), linePaint);
          startY += space;
        }
        break;
    }
  }

  @override
  bool shouldRepaint(_TimeLinePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_TimeLinePainter oldDelegate) => false;
}
