import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petcom/constants.dart';
import 'package:petcom/model/Post.dart';
import 'package:petcom/screens/Article/article_card.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class ArticleListDisplay extends StatefulWidget {
  ArticleListDisplay({
    Key? key,
  }) : super(key: key);

  @override
  _ArticleListDisplayPageState createState() => _ArticleListDisplayPageState();
}

class _ArticleListDisplayPageState extends State<ArticleListDisplay> {
  late HttpService http;
  bool _isLoading = false;

  PostResponse? _postResponse;
  List<Post> _post = <Post>[];
  int? _totalPage;

  Future getPost() async {
    Response response;
    try {
      _isLoading = true;
      response = await http.getRequest("/api/article/all?current=1");
      _postResponse = PostResponse.fromJson(jsonDecode(response.data));
      // if (_postResponse!.code == 200) {
      setState(() {
        _post += _postResponse!.post!;
        _totalPage = _postResponse!.totalPage!;
      });
      _isLoading = false;
      // }
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getPost();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kWhiteColor,
        child: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemCount: _post.length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: ScaleAnimation(
                          child: ArticleCard(
                            title: _post[index].title,
                            creatTime: DateTime.fromMicrosecondsSinceEpoch(
                                _post[index].createTime!),
                          ),
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
