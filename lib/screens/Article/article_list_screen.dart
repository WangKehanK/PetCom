import 'package:flutter/material.dart';
import 'package:petcom/constants.dart';
import 'package:petcom/model/PostList.dart';
import 'package:petcom/screens/Article/article_card.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ArticleList extends StatefulWidget {
  static String routeName = "/articles";

  ArticleList({
    Key? key,
  }) : super(key: key);

  @override
  _ArticleListPageState createState() => _ArticleListPageState();
}

class _ArticleListPageState extends State<ArticleList> {
  late HttpService http;
  PostList? postList;
  bool isLoading = false;

  List<PostList>? posts;
  dynamic data;
  Future getPost() async {
    Response response;
    try {
      isLoading = true;
      response = await http.getRequest("/api/index?current=1");
      isLoading = false;
      setState(() {
        data = response.data;
      });
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    http = HttpService();
    // getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kWhiteColor,
        child: Center(
          child: isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: 20, // data['breeder] == _pairList
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: ScaleAnimation(
                          child: ArticleCard(),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      Divider(
                    height: 16.0,
                    color: kPrimaryLightColor,
                  ),
                ),
        ));
  }
}
