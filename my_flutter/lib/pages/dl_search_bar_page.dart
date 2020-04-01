import 'package:flutter/material.dart';
import 'package:my_flutter/util/keyword_util.dart';
import 'package:my_flutter/widgets/dl_search_bar.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({Key key, this.defaultSearchWord}) : super(key: key);

  final String defaultSearchWord;

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
          defaultText: widget.defaultSearchWord,
          onChanged: (text) {
            if (mounted) {
              setState(() {
                _searchText = text;
              });
            }
          },
          onTapRightButton: () {
            Navigator.pop(context, '$_searchText');
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
