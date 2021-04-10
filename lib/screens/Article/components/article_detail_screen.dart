import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcom/model/Post.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';
import 'package:petcom/util.dart';

// ignore: must_be_immutable
class ArticleDetailsScreen extends StatefulWidget {
  String? id;
  Color? color;
  ArticleDetailsScreen({this.id, this.color});

  @override
  _ArticleDetailsScreenState createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  late HttpService http;
  bool _isLoading = false;

  PostResponse? _postResponse;
  List<Post> _post = <Post>[];
  Future getPostbyID(String? id) async {
    Response response;
    try {
      _isLoading = true;
      response = await http.getRequest("/api/article?id=$id");
      _postResponse = PostResponse.fromJson(jsonDecode(response.data));
      if (_postResponse!.code == 200) {
        setState(() {
          _post += _postResponse!.post!;
        });
        _isLoading = false;
      }
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getPostbyID(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : getBody(_post[0]),
    );
  }

  Widget getBody(Post post) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(randomPath()!), fit: BoxFit.contain),
              color: widget.color,
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: IconButton(
                              icon: Icon(
                                CupertinoIcons.back,
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.45),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${post.title!}",
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${post.content!}",
                    style: TextStyle(height: 1.6),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("Number of Views: ${post.score!.toString()}",
                      style: TextStyle(fontSize: 10)),
                  Text(
                      "Create at ${DateFormat.yMMMd().format(convertDate(post.createTime!))}",
                      style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
