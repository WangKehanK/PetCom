import 'package:petcom/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcom/screens/Search/search_result.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  final myController = TextEditingController();
  String? _text;
  textListener() {
    _text = myController.text;
    // print("Current Text is ${myController.text}");
  }

  @override
  void dispose() {
    super.dispose();
    myController.dispose();
  }

  @override
  void initState() {
    super.initState();
    myController.addListener(textListener);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: customShadow,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: myController,
              onChanged: (value) {
                // _text = value;
              },
              decoration: InputDecoration(
                hintText: "Search",
                hintStyle: TextStyle(
                  color: kBlackColor,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                // surffix isn't working properly  with SVG
                // thats why we use row
                // suffixIcon: SvgPicture.asset("assets/icons/search.svg"),
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                print("$_text");
                if (_text == null) {
                  print("enter something");
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return SearchResultScreen(
                      searchText: _text!,
                      type: 1,
                    );
                  }));
                }
              },
              child: Icon(CupertinoIcons.search)),
        ],
      ),
    );
  }
}
