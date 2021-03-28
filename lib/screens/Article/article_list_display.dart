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
  bool _hasMore = true;

  PostResponse? _postResponse;
  List<Post> _post = <Post>[];
  int? _nextPage;
  int? _currentPage;
  int? _totalPage;

  ScrollController _scrollController = new ScrollController();

  Future getPost(currentPage) async {
    Response response;
    try {
      _isLoading = true;
      response = await http
          .getRequest("/api/article/all?current=${currentPage.toString()}");
      _postResponse = PostResponse.fromJson(jsonDecode(response.data));
      if (_postResponse!.code == 200) {
        setState(() {
          _post += _postResponse!.post!;
          _totalPage = _postResponse!.totalPage!;
          this._totalPage = _postResponse!.totalPage!;
          this._currentPage = _postResponse!.currentPage!;
          this._nextPage = this._currentPage! + 1;
        });
        _isLoading = false;
      }
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  Future loadMore() async {
    getPost(1);
    //infinite loading
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //if we are at bottom of page
        this._isLoading = true;
        sleep1();
        if (this._nextPage! > this._totalPage!) {
          setState(() {
            _hasMore = false;
          });
        } else {
          getPost(this._nextPage);
          setState(() {
            _hasMore = true;
          });
        }
        print("current page: " + this._nextPage.toString());
        this._isLoading = false;
      }
    });
  }

  Future _refreshData() async {
    await sleep1();
    _post.clear();
    loadMore();
    setState(() {});
  }

  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 1), () => "1");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    http = HttpService();
    loadMore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: kWhiteColor,
        child: Center(
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView.separated(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: _post.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _post.length) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: ScaleAnimation(
                              child: ArticleCard(
                                post: _post[index],
                              ),
                            ),
                          ),
                        );
                      } else if (_hasMore) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(child: Text('nothing more to load!')),
                        );
                      }
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 16.0,
                      color: kPrimaryLightColor,
                    ),
                  ),
                ),
        ));
  }
}
