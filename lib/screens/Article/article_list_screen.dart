import 'package:flutter/material.dart';
import 'package:petcom/screens/Article/components/article_list_display.dart';

class ArticleScreen extends StatefulWidget {
  static String routeName = "/articles";

  ArticleScreen({Key? key}) : super(key: key);

  @override
  _ArticleScreenState createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Things worth to read"),
        ),
        body: ArticleListDisplay());
  }
}
