/*
 * @Author: shaolin 
 * @Date: 2020-04-01 11:07:37 
 * @Last Modified by: shaolin
 * @Last Modified time: 2020-04-01 11:21:37
 */

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter/util/img_util.dart';
import 'package:my_flutter/widgets/dl_button.dart';

/// alert 弹框圆角
const double _borderRadius = 6;

/// 图片位置
enum ImgPosition { top, center }

// 自定义弹窗方法
Future<T> showDLDialog<T>(
    {@required BuildContext context, @required WidgetBuilder builder}) {
  assert(builder != null, 'builder must not be null');

  final theme = Theme.of(context, shadowThemeOnly: true);
  return showGeneralDialog(
      context: context,
      pageBuilder: (builderContext, animation, secondaryAnimation) {
        final Widget pageChild = Builder(
          builder: builder,
        );
        return SafeArea(
          child: Builder(
              builder: (context) => theme != null
                  ? Theme(
                      data: theme,
                      child: pageChild,
                    )
                  : pageChild),
        );
      },
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: const Color.fromRGBO(0, 0, 0, 0.6), // 透明为60%的黑色
      transitionDuration: const Duration(milliseconds: 150),
      transitionBuilder: _buildMaterialDialogTransitions);
}

// 弹窗动画
Widget _buildMaterialDialogTransitions(
        BuildContext context,
        Animation<double> animation,
        Animation<double> secondaryAnimation,
        Widget child) =>
    FadeTransition(
      opacity: CurvedAnimation(
        parent: animation,
        curve: Curves.easeOut,
      ),
      child: child,
    );

/// 基础弹框
class BasicDialog extends Dialog {
  const BasicDialog(
      {Key key,
      this.title,
      this.titleTextStyle,
      this.content,
      this.contentTextStyle,
      this.leftButtonText,
      this.leftButtonTextStyle,
      this.onTapLeftButton,
      this.onTapRightButton,
      this.rightButtonText,
      this.rightButtonTextStyle,
      this.annotationText,
      this.linkText,
      this.onTapLinkText,
      this.actionAreaIsSingle = false,
      this.localImgPath = '',
      this.netImgUrl = '',
      this.localImgPackageName = '',
      this.imgPosition = ImgPosition.top,
      this.titleTopPadding = 0,
      this.actionAreaTopPadding = 0,
      this.commandTopPadding = 0,
      this.contentTopPadding = 0,
      this.imgTopPadding = 0})
      : super(key: key);

  /// 标题文本
  final String title;

  /// 标题样式
  final TextStyle titleTextStyle;

  /// 内容文本
  final String content;

  /// 内容样式
  final TextStyle contentTextStyle;

  /// 左侧按钮文本
  final String leftButtonText;

  /// 左侧按钮文本样式
  final TextStyle leftButtonTextStyle;

  /// 左侧按钮点击回调
  final VoidCallback onTapLeftButton;

  /// 右侧按钮文本
  final String rightButtonText;

  /// 右侧按钮文本样式
  final TextStyle rightButtonTextStyle;

  /// 右侧按钮点击回调
  final VoidCallback onTapRightButton;

  /// 注解 text
  final String annotationText;

  /// 注解可点击部分
  final String linkText;

  /// 点击部分回调
  final VoidCallback onTapLinkText;

  /// 操作区是否为单个按钮
  final bool actionAreaIsSingle;

  /// 本地图片路径
  final String localImgPath;

  /// 本地图片包名
  final String localImgPackageName;

  /// 网络图片地址
  final String netImgUrl;

  /// 图片位置
  final ImgPosition imgPosition;

  final double titleTopPadding;
  final double contentTopPadding;
  final double imgTopPadding;
  final double commandTopPadding;
  final double actionAreaTopPadding;

  @override
  Widget build(BuildContext context) {
    var imgWidget = localImgPath.isNotEmpty
        ? AlertLocalImgArea(
            path: localImgPath,
            packageName: localImgPackageName,
            imgPosition: imgPosition,
            topPadding: imgTopPadding,
          )
        : const SizedBox(
            height: 0,
          );
    if (netImgUrl.isNotEmpty) {
      imgWidget = AlertNetImgArea(
        imgUrl: netImgUrl,
        imgPosition: imgPosition,
        topPadding: imgTopPadding,
      );
    } else {
      const SizedBox(
        height: 0,
      );
    }

    // content 文本最大高度
    // TODO：优化（其他元素高度和大于 屏幕高 * 0.4 会溢屏）
    final contentTextContainerMaxHeight =
        (netImgUrl.isEmpty && localImgPath.isEmpty)
            ? MediaQuery.of(context).size.height * 0.3
            : MediaQuery.of(context).size.height * 0.1;

    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Navigator.pop(context);
        },
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(_borderRadius))),
            // 高度：屏幕高度的 70%
            // 宽度：屏幕宽度的 80%
            margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.1,
                vertical: MediaQuery.of(context).size.height * 0.15),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              // 空事件
              onTap: () {},
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // 图片
                        Offstage(
                          offstage: imgPosition != ImgPosition.top,
                          child: imgWidget,
                        ),
                        // 标题
                        AlertTitleArea(
                          title: title,
                          titleTextStyle: titleTextStyle,
                          topPadding: titleTopPadding,
                        ),
                        // 内容
                        AlertContentArea(
                          content: content,
                          contentTextStyle: contentTextStyle,
                          contentTextContainerMaxHeight:
                              contentTextContainerMaxHeight,
                          topPadding: contentTopPadding,
                        ),
                        // 图片
                        Offstage(
                          offstage: imgPosition != ImgPosition.center,
                          child: imgWidget,
                        ),
                        // 注释
                        AlertCommandArea(
                          annotationText: annotationText,
                          onTapLinkText: onTapLinkText,
                          linkText: linkText,
                          topPadding: commandTopPadding,
                        ),
                        // 操作区域
                        AlertActionArea(
                          isSingle: actionAreaIsSingle,
                          onTapRightButton: onTapRightButton,
                          onTapLeftButton: onTapLeftButton,
                          leftButtonText: leftButtonText,
                          rightButtonText: rightButtonText,
                          context: context,
                          topPadding: actionAreaTopPadding,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// alert 图片区域（网络资源）
class AlertNetImgArea extends StatelessWidget {
  const AlertNetImgArea(
      {Key key, this.imgUrl, this.imgPosition, this.topPadding = 0})
      : super(key: key);
  final String imgUrl;
  final ImgPosition imgPosition;
  final double topPadding;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(
            left: imgPosition == ImgPosition.top ? 0 : 16,
            right: imgPosition == ImgPosition.top ? 0 : 16,
            top: topPadding),
        child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft:
                    Radius.circular(imgPosition == ImgPosition.top ? 6 : 0),
                topRight:
                    Radius.circular(imgPosition == ImgPosition.top ? 6 : 0)),
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                  // 根据宽高建建议 16：9、4：3，定义最大宽度
                  maxHeight: MediaQuery.of(context).size.width * 3 / 4,
                ),
                child: FadeInImage.assetNetwork(
                    fit: BoxFit.fill,
                    placeholder: ImgUtil.namePath('test', 'jpg'),
                    image: '$imgUrl'))),
      );
}

/// alert 图片区域(本地资源)
class AlertLocalImgArea extends StatelessWidget {
  const AlertLocalImgArea(
      {Key key,
      this.path,
      this.packageName,
      this.imgPosition,
      this.topPadding = 0})
      : super(key: key);
  final String path;
  final String packageName;
  final ImgPosition imgPosition;
  final double topPadding;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.only(
            left: imgPosition == ImgPosition.top ? 0 : 16,
            right: imgPosition == ImgPosition.top ? 0 : 16,
            top: topPadding),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(imgPosition == ImgPosition.top ? 6 : 0),
              topRight:
                  Radius.circular(imgPosition == ImgPosition.top ? 6 : 0)),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
                // 根据宽高建议 16：9、4：3，定义最大高度
                maxHeight: MediaQuery.of(context).size.width * 3 / 4,
              ),
              child: Image(
                image: AssetImage('$path',
                    package: packageName.isEmpty ? null : packageName),
                fit: BoxFit.fill,
              )),
        ),
      );
}

/// alert 标题区域
class AlertTitleArea extends StatelessWidget {
  const AlertTitleArea(
      {Key key, this.title, this.titleTextStyle, this.topPadding = 0})
      : super(key: key);
  final String title;
  final TextStyle titleTextStyle;
  final double topPadding;

  @override
  Widget build(BuildContext context) => Offstage(
        offstage: title?.isEmpty ?? true,
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: topPadding),
          child: Text(title ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: titleTextStyle ??
                  const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal)),
        ),
      );
}

/// alert 内容区域
class AlertContentArea extends StatelessWidget {
  const AlertContentArea(
      {Key key,
      this.contentTextStyle,
      this.content,
      this.contentTextContainerMaxHeight,
      this.topPadding = 0})
      : super(key: key);
  final String content;
  final TextStyle contentTextStyle;
  final double contentTextContainerMaxHeight;
  final double topPadding;
  @override
  Widget build(BuildContext context) => Offstage(
        offstage: content?.isEmpty ?? true,
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: topPadding),
          child: Container(
              width: double.infinity,
              constraints:
                  BoxConstraints(maxHeight: contentTextContainerMaxHeight),
              child: Scrollbar(
                child: SingleChildScrollView(
                    child: Text(content ?? '',
                        textAlign: TextAlign.left,
                        style: contentTextStyle ??
                            const TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                fontStyle: FontStyle.normal))),
              )),
        ),
      );
}

/// alert 注释区域
class AlertCommandArea extends StatelessWidget {
  const AlertCommandArea(
      {Key key,
      this.annotationText,
      this.linkText,
      this.onTapLinkText,
      this.topPadding = 0})
      : super(key: key);
  final String annotationText;
  final String linkText;
  final VoidCallback onTapLinkText;
  final double topPadding;

  @override
  Widget build(BuildContext context) => Offstage(
        offstage: annotationText?.isEmpty ?? true,
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: topPadding),
          width: double.infinity,
          child: RichText(
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            text: TextSpan(children: [
              TextSpan(
                  text: '$annotationText??' '',
                  style: const TextStyle(color: Color(0xff888888))),
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap = onTapLinkText,
                text: '$linkText??' '',
                style: const TextStyle(color: Color(0xFF0B82F1)),
              )
            ]),
          ),
        ),
      );
}

/// alert 操作区域
class AlertActionArea extends StatelessWidget {
  const AlertActionArea(
      {Key key,
      this.onTapLeftButton,
      this.onTapRightButton,
      this.isSingle = false,
      this.context,
      this.leftButtonText = '取消',
      this.rightButtonText = '确定',
      this.topPadding = 0})
      : super(key: key);

  final String leftButtonText;
  final String rightButtonText;
  final VoidCallback onTapLeftButton;
  final VoidCallback onTapRightButton;
  final bool isSingle;
  final BuildContext context;
  final double topPadding;

  Widget get _cancel => isSingle
      ? const SizedBox(
          width: 0,
          height: 0,
        )
      : Expanded(
          flex: 1,
          child: Container(
            padding: EdgeInsets.only(right: 4, top: topPadding),
            child: DLSubButton(
              '$leftButtonText',
              onPressed: onTapLeftButton ?? Navigator.pop(context),
              height: 40,
              radius: 4.0,
            ),
          ),
        );

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            _cancel,
            Expanded(
              flex: 1,
              child: Container(
                padding:
                    EdgeInsets.only(left: isSingle ? 0 : 4, top: topPadding),
                child: DLMainButton(
                  '$rightButtonText',
                  onPressed: onTapRightButton ?? Navigator.pop(context),
                  height: 40,
                  radius: 4.0,
                ),
              ),
            ),
          ],
        ),
      );
}

/*
  依赖 BasicDialog 封装业务常用 Dialog
*/

// 图片在上方（本地资源）
class DialogWithTopLocalImg extends BasicDialog {
  const DialogWithTopLocalImg({
    @required String localImgPath,
    @required String title,
    @required String content,
    @required VoidCallback onTapLeftButton,
    @required VoidCallback onTapRightButton,
    String localImgPackageName = '',
    String leftButtonText = '取消',
    String rightButtonText = '确认',
  }) : super(
            title: title,
            content: content,
            leftButtonText: leftButtonText,
            onTapLeftButton: onTapLeftButton,
            rightButtonText: rightButtonText,
            onTapRightButton: onTapRightButton,
            localImgPath: localImgPath,
            localImgPackageName: localImgPackageName,
            imgTopPadding: 0,
            titleTopPadding: 16,
            contentTopPadding: 8,
            actionAreaTopPadding: 16);
}

// 图片在上方（网络资源）
class DialogWithTopNetImg extends BasicDialog {
  const DialogWithTopNetImg({
    @required String netImgUrl,
    @required String title,
    @required String content,
    @required VoidCallback onTapLeftButton,
    @required VoidCallback onTapRightButton,
    String leftButtonText = '取消',
    String rightButtonText = '确认',
  }) : super(
            title: title,
            content: content,
            leftButtonText: leftButtonText,
            onTapLeftButton: onTapLeftButton,
            rightButtonText: rightButtonText,
            onTapRightButton: onTapRightButton,
            netImgUrl: netImgUrl,
            imgTopPadding: 0,
            titleTopPadding: 16,
            contentTopPadding: 8,
            actionAreaTopPadding: 16);
}

// 图片在中间（本地资源）
class DialogWithCenterLocalImg extends BasicDialog {
  const DialogWithCenterLocalImg({
    @required String localImgPath,
    @required String title,
    @required String content,
    @required VoidCallback onTapLeftButton,
    @required VoidCallback onTapRightButton,
    String localImgPackageName = '',
    String leftButtonText = '取消',
    String rightButtonText = '确认',
  }) : super(
            title: title,
            content: content,
            leftButtonText: leftButtonText,
            onTapLeftButton: onTapLeftButton,
            rightButtonText: rightButtonText,
            onTapRightButton: onTapRightButton,
            localImgPath: localImgPath,
            localImgPackageName: localImgPackageName,
            imgPosition: ImgPosition.center,
            imgTopPadding: 8,
            titleTopPadding: 16,
            contentTopPadding: 8,
            actionAreaTopPadding: 16);
}

// 图片在中间（网络资源）
class DialogWithCenterNetImg extends BasicDialog {
  const DialogWithCenterNetImg({
    @required String netImgUrl,
    @required String title,
    @required String content,
    @required VoidCallback onTapLeftButton,
    @required VoidCallback onTapRightButton,
    String leftButtonText = '取消',
    String rightButtonText = '确认',
  }) : super(
            title: title,
            content: content,
            leftButtonText: leftButtonText,
            onTapLeftButton: onTapLeftButton,
            rightButtonText: rightButtonText,
            onTapRightButton: onTapRightButton,
            netImgUrl: netImgUrl,
            imgPosition: ImgPosition.center,
            imgTopPadding: 8,
            titleTopPadding: 16,
            contentTopPadding: 8,
            actionAreaTopPadding: 16);
}

// 带“注释”
class DialogWithCommand extends BasicDialog {
  const DialogWithCommand({
    @required String title,
    @required String content,
    @required VoidCallback onTapButton,
    @required VoidCallback onTapLinkText,
    @required String annotationText,
    @required String linkText,
    String buttonText = '确认',
  }) : super(
            title: title,
            content: content,
            rightButtonText: buttonText,
            onTapRightButton: onTapButton,
            annotationText: annotationText,
            linkText: linkText,
            onTapLinkText: onTapLinkText,
            actionAreaIsSingle: true,
            titleTopPadding: 16,
            contentTopPadding: 8,
            commandTopPadding: 8,
            actionAreaTopPadding: 16);
}

/// 常见
class DialogNormal extends BasicDialog {
  const DialogNormal({
    @required String title,
    @required String content,
    @required VoidCallback onTapLeftButton,
    @required VoidCallback onTapRightButton,
    String leftButtonText = '取消',
    String rightButtonText = '确认',
  }) : super(
            title: title,
            content: content,
            leftButtonText: leftButtonText,
            onTapLeftButton: onTapLeftButton,
            rightButtonText: rightButtonText,
            onTapRightButton: onTapRightButton,
            titleTopPadding: 16,
            contentTopPadding: 8,
            actionAreaTopPadding: 16);
}

/// 常见，只带标题
class DialogNormalOnlyTitle extends BasicDialog {
  const DialogNormalOnlyTitle({
    @required String title,
    @required VoidCallback onTapLeftButton,
    @required VoidCallback onTapRightButton,
    String leftButtonText = '取消',
    String rightButtonText = '确认',
  }) : super(
            title: title,
            leftButtonText: leftButtonText,
            onTapLeftButton: onTapLeftButton,
            rightButtonText: rightButtonText,
            onTapRightButton: onTapRightButton,
            titleTopPadding: 16,
            actionAreaTopPadding: 12);
}

/// 常见，只带内容
class DialogNormalOnlyContent extends BasicDialog {
  const DialogNormalOnlyContent({
    @required String content,
    @required VoidCallback onTapLeftButton,
    @required VoidCallback onTapRightButton,
    String leftButtonText = '取消',
    String rightButtonText = '确认',
  }) : super(
          content: content,
          leftButtonText: leftButtonText,
          onTapLeftButton: onTapLeftButton,
          rightButtonText: rightButtonText,
          onTapRightButton: onTapRightButton,
          contentTopPadding: 16,
          actionAreaTopPadding: 12,
        );
}
