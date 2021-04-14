import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
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
        boxShadow: customShadow,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
                      textInputAction: TextInputAction.done,
                      onSubmitted: (value){
                        if (_text == null) {
                          Dialogs.bottomMaterialDialog(
                              msg: 'Please enter something',
                              title: 'Note!',
                              context: context,
                              actions: [
                                IconsOutlineButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'OK!',
                                  iconData: Icons.done,
                                  textStyle: TextStyle(color: Colors.grey),
                                  iconColor: Colors.grey,
                                ),
                              ]);
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SearchResultScreen(
                              searchText: _text!,
                              type: 1,
                            );
                          }));
                        }
                      },
              controller: myController,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: "Search Breeder",
                hintStyle: TextStyle(
                  color: kBlackColor,
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          GestureDetector(
              onTap: () {
                if (_text == null) {
                  Dialogs.bottomMaterialDialog(
                      msg: 'Please enter something',
                      title: 'Note!',
                      context: context,
                      actions: [
                        IconsOutlineButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          text: 'OK!',
                          iconData: Icons.done,
                          textStyle: TextStyle(color: Colors.grey),
                          iconColor: Colors.grey,
                        ),
                      ]);
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
