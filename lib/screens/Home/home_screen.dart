import 'dart:convert';
import 'package:petcom/components/build_title.dart';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/model/Post.dart';
import 'package:petcom/screens/Article/article_list_screen.dart';
import 'package:petcom/screens/Home/components/square_banner_card.dart';
import 'package:flutter/material.dart';
import 'package:petcom/screens/Home/components/header_with_searchbox.dart';
import 'package:petcom/screens/Home/components/new_banner_card.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';

import 'package:petcom/util.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/index";

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HttpService? http;
  bool _isLoading = false;

  //json to dart
  BreederResponse? _breederResponse;
  PostResponse? _postResponse;

  List<Post> _post = <Post>[];
  List<Breeder> _breeder = <Breeder>[];

  Future getFeatureContent() async {
    Response articleData;
    Response breederData;
    try {
      _isLoading = true;
      articleData = await http!.getRequest("/api/article/feature");
      breederData = await http!.getRequest("/api/breeder/feature");

      _postResponse = PostResponse.fromJson(jsonDecode(articleData.data));
      _breederResponse = BreederResponse.fromJson(jsonDecode(breederData.data));
      if (_postResponse!.code == 200 && _breederResponse!.code == 200) {
        setState(() {
          _post += _postResponse!.post!;
          _breeder += _breederResponse!.breeder!;
        });
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
    getFeatureContent();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: _isLoading
          ? Center(
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        HeaderWithSearchBox(size: size),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        buildTitleWithPush(context, "Featured ", "Article",
                            ArticleScreen.routeName),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              NewBannerCard(
                                id: _post[0].id.toString(),
                                imagePath: "assets/images/banner1.png",
                                title: smallSentence(
                                    _post.elementAt(0).title ?? ""),
                              ),
                              NewBannerCard(
                                id: _post[1].id.toString(),
                                imagePath: "assets/images/banner2.png",
                                title: smallSentence(
                                    _post.elementAt(1).title ?? ""),
                              ),
                              NewBannerCard(
                                id: _post[2].id.toString(),
                                imagePath: "assets/images/banner3.png",
                                title: smallSentence(
                                    _post.elementAt(2).title ?? ""),
                              ),
                              NewBannerCard(
                                id: _post[3].id.toString(),
                                imagePath: "assets/images/banner4.png",
                                title: smallSentence(
                                    _post.elementAt(3).title ?? ""),
                              ),
                            ],
                          ),
                        ),
                        BuildTitle(" Recommend ", "Owners"),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: <Widget>[
                              SquareBannerCard(
                                id: _breeder.elementAt(0).id.toString(),
                                image: getDesiredImagePath(
                                    _breeder.elementAt(0).type.toString()),
                                title: mediumSentence(
                                    _breeder.elementAt(0).title ?? ""),
                                rating: _breeder.elementAt(0).score!,
                                type: _breeder.elementAt(0).type!,
                              ),
                              SquareBannerCard(
                                id: _breeder.elementAt(1).id.toString(),
                                image: getDesiredImagePath(
                                    _breeder.elementAt(1).type.toString()),
                                title: mediumSentence(
                                    _breeder.elementAt(1).title ?? ""),
                                rating: _breeder.elementAt(1).score!,
                                type: _breeder.elementAt(1).type!,
                              ),
                              SquareBannerCard(
                                id: _breeder.elementAt(2).id.toString(),
                                image: getDesiredImagePath(
                                    _breeder.elementAt(2).type.toString()),
                                title: mediumSentence(
                                    _breeder.elementAt(2).title ?? ""),
                                rating: _breeder.elementAt(2).score!,
                                type: _breeder.elementAt(2).type!,
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
}
