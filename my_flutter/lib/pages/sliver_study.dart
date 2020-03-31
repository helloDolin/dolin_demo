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
              'https://avatars1.githubusercontent.com/u/12538263?s=460&u=80384da08e252036d7ffe5da82a7908b27296688&v=4',
              fit: BoxFit.cover,
            ),
            expandedHeight: 300,
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
