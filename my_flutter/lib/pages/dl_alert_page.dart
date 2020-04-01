import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_alert.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';
import 'package:my_flutter/widgets/simple_btn.dart';

class DLAlertPage extends StatefulWidget {
  const DLAlertPage({Key key}) : super(key: key);

  @override
  _DLAlertPageState createState() => _DLAlertPageState();
}

class _DLAlertPageState extends State<DLAlertPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            DLAppBar('hl_alert', onTapBackBtn: () => Navigator.pop(context)),
        body: Container(
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SimpleBtn(
                  title: 'DialogWithTopLocalImg',
                  tap: _dialogWithTopLocalImg,
                  subTitle: '本地图片在上方弹框',
                ),
                SimpleBtn(
                  title: 'DialogWithTopNetlImg',
                  tap: _dialogWithTopNetImg,
                  subTitle: '网络图片在上方弹框',
                ),
                SimpleBtn(
                  title: 'DialogWithCenterLocalImg',
                  tap: _dialogWithCenterLocalImg,
                  subTitle: '本地图片在中间弹框',
                ),
                SimpleBtn(
                  title: 'DialogWithCenterNetImg',
                  tap: _dialogWithCenterNetImg,
                  subTitle: '网络图片在中间弹框',
                ),
                SimpleBtn(
                  title: 'DialogWithCommand',
                  tap: _dialogWithCommand,
                  subTitle: '带注释（超链接）的弹框',
                ),
                SimpleBtn(
                  title: 'DialogNormal',
                  tap: _dialogNormal,
                  subTitle: '常见的取消确认弹框',
                ),
                SimpleBtn(
                  title: 'DialogNormalOnlyTitle',
                  tap: _dialogNormalOnlyTitle,
                  subTitle: '常见的取消确认弹框（仅带标题）',
                ),
                SimpleBtn(
                  title: 'DialogNormalOnlyContent',
                  tap: _dialogNormalOnlyContent,
                  subTitle: '常见的取消确认弹框（仅带内容）',
                ),
              ],
            ),
          ),
        ));
  }

  void _dialogNormalOnlyContent() {
    showDLDialog(
        context: context,
        builder: (context) {
          return DialogNormalOnlyContent(
            content:
                'contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent',
            onTapLeftButton: () {
              Navigator.pop(context);
            },
            onTapRightButton: () {
              Navigator.pop(context);
            },
          );
        });
  }

  void _dialogNormalOnlyTitle() {
    showDLDialog(
        context: context,
        builder: (context) {
          return DialogNormalOnlyTitle(
            title: '只有标题',
            onTapLeftButton: () {
              Navigator.pop(context);
            },
            onTapRightButton: () {
              Navigator.pop(context);
            },
          );
        });
  }

  void _dialogNormal() {
    showDLDialog(
        context: context,
        builder: (context) {
          return DialogNormal(
            title: 'title',
            content:
                'contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent',
            onTapLeftButton: () {
              Navigator.pop(context);
            },
            onTapRightButton: () {
              Navigator.pop(context);
            },
          );
        });
  }

  void _dialogWithCommand() {
    showDLDialog(
        context: context,
        builder: (context) {
          return DialogWithCommand(
              title: 'title',
              content:
                  'contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent',
              onTapButton: () {
                Navigator.pop(context);
              },
              buttonText: 'hahah',
              annotationText: 'annotationText',
              linkText: '我是链接我是链接我是链接我是链接我是链接我是链接我是链接我是链接我是链接',
              onTapLinkText: () {
                Navigator.pop(context);
              });
        });
  }

  void _dialogWithTopLocalImg() {
    showDLDialog(
        context: context,
        builder: (context) {
          return DialogWithTopLocalImg(
              title: 'title',
              content:
                  'contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent',
              onTapLeftButton: () {
                Navigator.pop(context);
              },
              onTapRightButton: () {
                Navigator.pop(context);
              },
              localImgPath: 'assets/imgs/test.jpg');
        });
  }

  void _dialogWithTopNetImg() {
    showDLDialog(
        context: context,
        builder: (context) {
          return DialogWithTopNetImg(
              title: 'title',
              content:
                  'contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent',
              onTapLeftButton: () {
                Navigator.pop(context);
              },
              onTapRightButton: () {
                Navigator.pop(context);
              },
              netImgUrl:
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582000666297&di=5abda0435fbb67243936a4410ae6f9c8&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658');
        });
  }

  void _dialogWithCenterLocalImg() {
    showDLDialog(
        context: context,
        builder: (context) {
          return DialogWithCenterLocalImg(
              title: 'title',
              content:
                  'contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent',
              onTapLeftButton: () {
                Navigator.pop(context);
              },
              onTapRightButton: () {
                Navigator.pop(context);
              },
              localImgPath: 'assets/imgs/test.jpg');
        });
  }

  void _dialogWithCenterNetImg() {
    showDLDialog(
        context: context,
        builder: (context) {
          return DialogWithCenterNetImg(
              title: 'title',
              content:
                  'contentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontentcontent',
              onTapLeftButton: () {
                Navigator.pop(context);
              },
              onTapRightButton: () {
                Navigator.pop(context);
              },
              netImgUrl:
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582000666297&di=5abda0435fbb67243936a4410ae6f9c8&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658');
        });
  }
}
