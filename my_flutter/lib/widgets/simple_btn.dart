import 'dart:math';

import 'package:flutter/material.dart';

class SimpleBtn extends StatelessWidget {
  const SimpleBtn({Key key, this.tap, this.title, this.subTitle = ''})
      : super(key: key);
  final VoidCallback tap;
  final String title;
  final String subTitle;

  @override
  Widget build(BuildContext context) {
    // 仿小程序 rpx
    final rpx = MediaQuery.of(context).size.width / 375;
    // 随机色
    final randomColor = Color.fromRGBO(
        Random().nextInt(255), Random().nextInt(255), Random().nextInt(255), 1);
    // 根据明暗调整 title 颜色
    final brightnessValue = randomColor.computeLuminance();
    final titleColor = brightnessValue > 0.5 ? Colors.black : Colors.white;

    return InkWell(
      onTap: tap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(6 * rpx)),
          color: randomColor,
        ),
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          children: <Widget>[
            Text(
              '$title',
              textAlign: TextAlign.center,
              style: TextStyle(color: titleColor, fontWeight: FontWeight.w500),
            ),
            Offstage(
              offstage: subTitle.isEmpty,
              child: Text(
                '${subTitle ?? ''}',
                textAlign: TextAlign.center,
                style: TextStyle(color: titleColor, fontSize: 10),
              ),
            )
          ],
        ),
      ),
    );
  }
}
