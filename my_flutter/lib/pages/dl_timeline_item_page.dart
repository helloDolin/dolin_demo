import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';
import 'package:my_flutter/widgets/dl_timeline_item.dart';

class DLTimelineItemPage extends StatefulWidget {
  const DLTimelineItemPage({Key key}) : super(key: key);

  @override
  _DLTimelineItemPageState createState() => _DLTimelineItemPageState();
}

class _DLTimelineItemPageState extends State<DLTimelineItemPage> {
  @override
  Widget build(BuildContext context) {
    const testStr = '''
对酒当歌，人生几何！譬如朝露，去日苦多。
慨当以慷，忧思难忘。何以解忧？唯有杜康。
青青子衿，悠悠我心。但为君故，沉吟至今。
呦呦鹿鸣，食野之苹。我有嘉宾，鼓瑟吹笙。
明明如月，何时可掇？忧从中来，不可断绝。
越陌度阡，枉用相存。契阔谈䜩，心念旧恩。
月明星稀，乌鹊南飞。绕树三匝，何枝可依？
山不厌高，海不厌深。周公吐哺，天下归心。
     ''';

    return Scaffold(
      appBar: DLAppBar('DLTimelineItemPage', onTapBackBtn: () {
        Navigator.pop(context);
      }),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            DLTimelineItem(
              timelineColor: Colors.cyan,
              isEnd: true,
              nodeTopPadding: 20,
              nodeWidget: Container(
                width: 24,
                height: 24,
                color: Colors.yellow,
                child: Icon(
                  Icons.home,
                  size: 24,
                ),
              ),
              child: const _TestChild(str: testStr),
            ),
            DLTimelineItem(
              nodeTopPadding: 18,
              nodeColor: Colors.blue,
              child: const _TestChild(str: testStr),
            ),
            DLTimelineItem(
              nodeTopPadding: 18,
              timelineColor: Colors.black,
              timeLineType: DLTimelineType.dot,
              child: const _TestChild(str: testStr),
            ),
            DLTimelineItem(
              isFirst: true,
              timelineColor: Colors.red,
              nodeTopPadding: 40,
              nodeWidget: Container(
                width: 30,
                height: 24,
                child: Text(
                  'nice',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              child: const _TestChild(str: testStr),
            ),
          ],
        ),
      )),
    );
  }
}

class _TestChild extends StatelessWidget {
  const _TestChild({Key key, this.str}) : super(key: key);
  final String str;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, top: 10),
      child: Text('$str'),
    );
  }
}
