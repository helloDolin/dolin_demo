import 'package:flutter/material.dart';

class ImgUtil {
  static String namePath(String name, String suffix) {
    print('assets/imgs/$name.$suffix');
    return 'assets/imgs/$name.$suffix';
  }

  static Widget img(String name, String suffix,
      {double width, double height, BoxFit boxfit}) {
    return Image.asset(
      namePath(name, suffix),
      width: width,
      height: height,
      fit: boxfit,
    );
  }
}
