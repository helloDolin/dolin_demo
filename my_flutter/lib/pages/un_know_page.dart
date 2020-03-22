import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';

class UnKnowPage extends StatelessWidget {
  const UnKnowPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DLAppBar(
        'UnKnowPage',
        onTapBackBtn: () {
          Navigator.pop(context);
        },
      ),
      body: const Center(
        child: Text('onUnknownRoute'),
      ),
    );
  }
}
