import 'package:flutter/material.dart';
import 'package:my_flutter/widgets/dl_search_bar.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({Key key}) : super(key: key);

  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  String _showText = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DLSearchBar(
          autoFocus: true,
          hint: 'hint',
          onChanged: (text) {
            if (mounted) {
              setState(() {
                _showText = text;
              });
            }
          },
        ),
        body: Align(alignment: Alignment.topCenter, child: Text('$_showText')));
  }
}
