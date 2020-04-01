import 'package:flutter/material.dart';
import 'package:my_flutter/util/keyword_util.dart';
import 'package:my_flutter/widgets/dl_search_bar.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({Key key}) : super(key: key);

  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {
  final String _showText = 'AbcdefgAbcdefgaaa';
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: DLSearchBar(
          autoFocus: true,
          hint: 'hint',
          onChanged: (text) {
            if (mounted) {
              setState(() {
                _searchText = text;
              });
            }
          },
        ),
        body: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.topCenter,
                child: Text(
                  '$_showText',
                  style: TextStyle(fontSize: 14, color: Colors.black),
                )),
            RichText(
              text: TextSpan(
                children: KeywordUtil.keywordTextSpans(_showText, _searchText),
              ),
            ),
          ],
        ));
  }
}
