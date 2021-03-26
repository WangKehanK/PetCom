import 'dart:convert';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/model/Post.dart';
import 'package:petcom/screens/Article/article_detail_screen.dart';
import 'package:petcom/screens/Article/article_list_screen.dart';
import 'package:petcom/screens/Breeder/details_screen.dart';
import 'package:petcom/screens/Home/components/square_banner_card.dart';
import 'package:flutter/material.dart';
import 'package:petcom/screens/Home/components/header_with_searchbox.dart';
import 'package:petcom/screens/Home/components/new_banner_card.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';
import 'dart:math';

import 'package:petcom/util.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/index";

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HttpService? http;
  Random _random = new Random();
  bool _isLoading = false;

  //json to dart
  BreederResponse? _breederResponse;

  PostResponse? _postResponse;
  List<Post> _post = <Post>[];

  Future getFeaturePost() async {
    Response response;
    try {
      _isLoading = true;
      response = await http!.getRequest("/api/article/feature");
      _postResponse = PostResponse.fromJson(jsonDecode(response.data));
      if (_postResponse!.code == 200) {
        setState(() {
          _post += _postResponse!.post!;
        });
        print(_post);
      }
      _isLoading = false;
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getFeaturePost();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: _isLoading
                  ? Center(
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(),
                          height: 24,
                          width: 24,
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        HeaderWithSearchBox(size: size),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        buildTitleWithPush(context, "Featured ", "Article",
                            ArticleScreen.routeName),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              NewBannerCard(
                                size: size,
                                id: 1,
                                imagePath: "assets/images/banner3.png",
                                title: _post.elementAt(0).title ?? "",
                              ),
                              NewBannerCard(
                                size: size,
                                id: 1,
                                imagePath: "assets/images/banner3.png",
                                title: smallSentence(
                                    _post.elementAt(1).title ?? ""),
                              ),
                              NewBannerCard(
                                size: size,
                                id: 2,
                                imagePath: "assets/images/banner4.png",
                                title: smallSentence(
                                    _post.elementAt(2).title ?? ""),
                              ),
                              NewBannerCard(
                                size: size,
                                id: 3,
                                imagePath: "assets/images/banner4.png",
                                title: smallSentence(
                                    _post.elementAt(3).title ?? ""),
                              ),
                            ],
                          ),
                        ),
                        buildTitle(context, " Recommend ", "Owners"),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              SquareBannerCard(
                                image: "assets/images/cat-1.png",
                                title: "Sunshine Kitten House",
                                auth: "",
                                rating: 4.9,
                                pressDetails: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailsScreen(
                                          id: "1",
                                        );
                                      },
                                    ),
                                  );
                                },
                              ),
                              SquareBannerCard(
                                image: "assets/images/cat-1.png",
                                title: "Sunshine Puppy House",
                                auth: "",
                                rating: 4.8,
                              ),
                              SquareBannerCard(
                                image: "assets/images/cat-1.png",
                                title: "Sunshine Puppy House",
                                auth: "",
                                rating: 4.8,
                              ),
                              SizedBox(width: 30),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTitleWithPush(
      BuildContext context, String s1, String s2, String routeName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: TextButton(
        onPressed: () {
          try {
            Navigator.pushNamed(context, routeName);
          } on Exception catch (e) {
            print(e);
          }
        },
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline5,
                children: [
                  TextSpan(text: s1),
                  TextSpan(
                    text: s2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(width: 60),
            Container(
              child: (routeName == '')
                  ? Icon(Icons.pets)
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildTitle(BuildContext context, String s1, String s2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
        ),
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline5,
                children: [
                  TextSpan(text: s1),
                  TextSpan(
                    text: s2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
