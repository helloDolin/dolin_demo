import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';

class HeroTestPage extends StatefulWidget {
  const HeroTestPage({Key key}) : super(key: key);

  @override
  _HeroTestPageState createState() => _HeroTestPageState();
}

class _HeroTestPageState extends State<HeroTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DLAppBar(
        'HeroTestPage',
        onTapBackBtn: () {
          Navigator.pop(context);
        },
      ),
      body: Hero(
        tag: 'hero_test',
        child: Container(
          width: 300,
          height: 300,
          child: const FlutterLogo(),
        ),
      ),
    );
  }
}
