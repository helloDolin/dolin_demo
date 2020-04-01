import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';
import 'package:my_flutter/widgets/dl_button.dart';

class DLButtonPage extends StatefulWidget {
  const DLButtonPage({Key key}) : super(key: key);

  @override
  _DLButtonPageState createState() => _DLButtonPageState();
}

class _DLButtonPageState extends State<DLButtonPage> {
  String _showText = '';

  void _clickBtn(String text) {
    if (mounted) {
      setState(() {
        _showText = text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DLAppBar(
        'DLButtonPage',
        onTapBackBtn: () {
          Navigator.pop(context);
        },
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          _Item(
            child: DLMainButton(
              '主按钮',
              onPressed: () => _clickBtn('主按钮'),
            ),
          ),
          _Item(
            child: DLSubButton(
              '次按钮',
              onPressed: () => _clickBtn('次按钮'),
            ),
          ),
          _Item(
            child: DLMainButton(
              '主按钮（不可点）',
              onPressed: () {},
              disabled: true,
            ),
          ),
          _Item(
              child: DLSubButton(
            '次按钮（不可点）',
            onPressed: () {},
            disabled: true,
          )),
          _Item(
            child: DLMainButton(
              '主标题',
              onPressed: () => _clickBtn('子标题按钮'),
              disabled: false,
              icon: const Icon(Icons.home, size: 28, color: Colors.yellow),
              padding: const EdgeInsets.symmetric(horizontal: 100),
            ),
          ),
          _Item(
            child: DLMainButton(
              '主标题',
              onPressed: () => _clickBtn('带icon主按钮'),
              disabled: false,
              subText: '子标题',
              icon: Container(
                  width: 20,
                  height: 20,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.white,
                  )),
              padding: const EdgeInsets.symmetric(horizontal: 100),
            ),
          ),
          _Item(
            child: HLDoubleWidgetContainer(
              backgroundColor: const Color(0xFFF5F5F5),
              height: 60,
              width: 300,
              padding: 20,
              leftWidget: DLSubButton(
                'left',
                onPressed: () => _clickBtn('left'),
              ),
              rightWidget: DLMainButton(
                'right',
                onPressed: () => _clickBtn('right'),
              ),
            ),
          ),
          _Item(
            child: Text(
              '$_showText',
              style: TextStyle(fontSize: 24, color: Colors.red),
            ),
          )
        ],
      )),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({Key key, this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: child,
    );
  }
}
