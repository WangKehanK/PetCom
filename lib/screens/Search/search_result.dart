import 'package:flutter/material.dart';

class SearchResultScreen extends StatefulWidget {
  static String routeName = "/search_result";

  const SearchResultScreen({
    Key? key,
    required this.searchText,
  }) : super(key: key);

  final String searchText;

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    // String? _searchText;
    // final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    // if (arguments != null) _searchText = (arguments['searchText']);
    // print(arguments['searchText']);

    return Scaffold(
      appBar: AppBar(title: Text("Search Result of '${widget.searchText}'")),
      body: Text("${widget.searchText}"),
    );
  }
}
