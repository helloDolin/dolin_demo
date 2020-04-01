import 'package:flutter/material.dart';

class SliverStudyPage extends StatefulWidget {
  const SliverStudyPage({Key key}) : super(key: key);

  @override
  _SliverStudyPageState createState() => _SliverStudyPageState();
}

class _SliverStudyPageState extends State<SliverStudyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: const Text(
              'SliverStudyPage',
              style: TextStyle(color: Colors.white),
            ),
            floating: true,
            flexibleSpace: Image.network(
              'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1582000666297&di=5abda0435fbb67243936a4410ae6f9c8&imgtype=0&src=http%3A%2F%2Fhbimg.b0.upaiyun.com%2F357d23d074c2954d568d1a6f86a5be09d190a45116e95-0jh9Pg_fw658',
              fit: BoxFit.cover,
            ),
            expandedHeight: 260,
          ),
          SliverList(
            // SliverList 作为列表控件
            delegate: SliverChildBuilderDelegate(
              (context, index) => ListTile(title: Text('Item #$index')),
              childCount: 100,
            ),
          ),
        ],
      ),
    );
  }
}
