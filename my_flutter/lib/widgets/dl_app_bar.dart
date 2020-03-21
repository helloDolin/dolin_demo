import 'package:flutter/material.dart';

class DLAppBar extends AppBar {
  DLAppBar(this.pageTitle,
      {Key key,
      this.isHideBackBtn = false,
      this.onTapBackBtn,
      this.zValue = 1.0,
      PreferredSizeWidget bottom,
      List<Widget> actions})
      : assert(pageTitle != null, 'pageTitle must not be null'),
        super(
          key: key,
          title: Text(
            pageTitle,
            style: const TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xffffffff),
          brightness: Brightness.light,
          elevation: zValue,
          leading: Offstage(
            offstage: isHideBackBtn,
            child: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 16,
                ),
                onPressed: onTapBackBtn),
          ),
          bottom: bottom,
          actions: actions,
        );

  final String pageTitle;
  final bool isHideBackBtn;
  final VoidCallback onTapBackBtn;
  final double zValue;
}
