import 'package:flutter/material.dart';
import 'package:my_flutter/util/img_util.dart';
import 'package:my_flutter/widgets/dl_app_bar.dart';
import 'package:my_flutter/widgets/loading_container.dart';

class Page extends StatefulWidget {
  Page({Key key}) : super(key: key);

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DLAppBar(
        'block_chain_analyze',
        onTapBackBtn: () {
          Navigator.pop(context);
        },
      ),
      body: LoadingContainer(
        child: ImgUtil.img('test', 'jpg'),
        isLoading: false,
      ),
    );
  }
}
