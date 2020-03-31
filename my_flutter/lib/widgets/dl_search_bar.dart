/*
 * @Author: shaolin 
 * @Date: 2020-03-31 19:51:42 
 * @Last Modified by: shaolin
 * @Last Modified time: 2020-03-31 19:59:27
 */

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class DLSearchBar extends StatefulWidget implements PreferredSizeWidget {
  const DLSearchBar(
      {Key key,
      this.autoFocus = false,
      this.onTapRightButton,
      this.rightButtonText = '取消',
      this.rightButtonTextStyle =
          const TextStyle(fontSize: 15, color: Color(0xff666666)),
      this.hint,
      this.defaultText,
      this.onChanged})
      // 仿 SDK AppBar 写法
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  /// 是否自动弹起键盘
  final bool autoFocus;

  /// 占位字符
  final String hint;

  /// 默认输入
  final String defaultText;

  /// 右边按钮文本
  final String rightButtonText;

  /// 右边按钮文本样式
  final TextStyle rightButtonTextStyle;

  /// 右边按钮点击回调
  final VoidCallback onTapRightButton;

  /// 文本输入回调
  final ValueChanged<String> onChanged;

  @override
  _DLSearchBarState createState() => _DLSearchBarState();

  @override
  final Size preferredSize;
}

class _DLSearchBarState extends State<DLSearchBar> {
  // 是否展示 × 号
  bool _showClear = false;
  // 文本控制器
  final TextEditingController _controller = TextEditingController();
  // 搜索框高度
  final double _searchBarHeight = 36;

  @override
  void initState() {
    if (widget.defaultText != null) {
      _controller.text = widget.defaultText;
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Container(
        // 60 / 88 = 0.68
        alignment: const Alignment(-1, 0.68),
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            _inputBox,
            _cancelButton(context),
          ],
        ),
      );

  /// 取消按钮
  Widget _cancelButton(BuildContext context) => InkWell(
      onTap: widget?.onTapRightButton ??
          () {
            // 隐藏键盘
            FocusScope.of(context).requestFocus(FocusNode());
            // 出栈
            Navigator.pop(context);
          },
      child: Container(
        alignment: Alignment.center,
        height: _searchBarHeight,
        padding: const EdgeInsets.only(left: 12, right: 18),
        child: Text(
          '${widget.rightButtonText}',
          style: widget.rightButtonTextStyle,
        ),
      ));

  /// 输入区域
  Widget get _inputBox => Expanded(
        flex: 1,
        child: Container(
          height: _searchBarHeight,
          padding: const EdgeInsets.only(left: 15, right: 0),
          margin: const EdgeInsets.only(
            left: 15,
          ),
          decoration: BoxDecoration(
            color: const Color(0xffF5F5F5),
            borderRadius: BorderRadius.circular(
                18 * MediaQuery.of(context).size.width / 375),
          ),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(right: 5),
                child: Icon(
                  Icons.search,
                  size: 15,
                  color: const Color(0xffbbbbbb),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: TextField(
                    controller: _controller,
                    onChanged: _onChanged,
                    autofocus: widget.autoFocus,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w300),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: widget.hint ?? '',
                        hintStyle: const TextStyle(fontSize: 14)),
                  )),
              Offstage(
                offstage: !_showClear,
                child: InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    _controller.clear();
                    _onChanged('');
                  },
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: _searchBarHeight - 6,
                    height: _searchBarHeight,
                    child: const Icon(
                      Icons.close,
                      size: 15,
                      color: Color(0xffbbbbbb),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );

  // 输入框内容改变
  void _onChanged(String text) {
    if (mounted) {
      setState(() {
        _showClear = text.isNotEmpty;
      });
    }
    // 回调
    if (widget.onChanged != null) {
      widget.onChanged(text.trim());
    }
  }
}
