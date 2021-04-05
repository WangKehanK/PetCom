import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:petcom/constants.dart';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/screens/Breeder/pet_card.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:petcom/screens/Article/article_card.dart';
import 'package:petcom/model/Post.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class SearchResultScreen extends StatefulWidget {
  static String routeName = "/search_result";

  const SearchResultScreen({
    Key? key,
    required this.searchText,
    required this.type,
  }) : super(key: key);

  final String searchText;
  final int type; // 0 for article, 1 for breeder

  @override
  _SearchResultScreenState createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  late HttpService http;
  bool _isLoading = false;
  bool _hasMore = true;

  PostResponse? _postResponse;
  BreederResponse? _breederResponse;

  List<Post> _post = <Post>[];
  List<Breeder> _breeder = <Breeder>[];

  Future getData() async {
    Response response;
    try {
      _isLoading = true;
      if (widget.type == 0) {
        response = await http
            .getRequest("/api/article/search?searchKey=${widget.searchText}");
        _postResponse = PostResponse.fromJson(jsonDecode(response.data));
        if (_postResponse!.code == 200) {
          setState(() {
            _post += _postResponse!.post!;
            _hasMore = false;
          });
        }
        _isLoading = false;
      } else if (widget.type == 1) {
        response = await http
            .getRequest("/api/breeder/search?searchKey=${widget.searchText}");
        _breederResponse = BreederResponse.fromJson(jsonDecode(response.data));
        print(_breederResponse!.breeder);
        if (_breederResponse!.code == 200) {
          setState(() {
            _breeder += _breederResponse!.breeder!;
            _hasMore = false;
          });
        }
        _isLoading = false;
      }
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    http = HttpService();
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(_breeder.toString());
    return Scaffold(
      appBar: AppBar(title: Text("Search Result of '${widget.searchText}'")),
      body: Container(
          color: kWhiteColor,
          child: Center(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : (widget.type == 0)
                    ? ListView.separated(
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
                              child:
                                  Center(child: Text('nothing more to load!')),
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 16.0,
                          color: kPrimaryLightColor,
                        ),
                      )
                    : ListView.separated(
                        physics: BouncingScrollPhysics(),
                        itemCount: _breeder.length + 1,
                        itemBuilder: (context, index) {
                          if (index < _breeder.length) {
                            return AnimationConfiguration.staggeredList(
                              position: index,
                              child: SlideAnimation(
                                verticalOffset: 50.0,
                                child: ScaleAnimation(
                                  child: PetCard(
                                    id: _breeder[index].id,
                                    title: _breeder[index].title,
                                    score: _breeder[index].score,
                                    type: _breeder[index].type,
                                    description: _breeder[index].description,
                                    createTime:
                                        _breeder[index].createTime.toString(),
                                    address: _breeder[index].address,
                                    city: _breeder[index].city,
                                    state: _breeder[index].state,
                                    contact: _breeder[index].contact,
                                    website: _breeder[index].website,
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
                              child:
                                  Center(child: Text('nothing more to load!')),
                            );
                          }
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 16.0,
                          color: kPrimaryLightColor,
                        ),
                      ),
          )),
    );
  }
}
