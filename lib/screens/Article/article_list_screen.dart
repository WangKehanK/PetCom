import 'package:flutter/material.dart';
import 'package:petcom/model/PostList.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';

class ArticleList extends StatefulWidget {
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
    getPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
            child: isLoading
                ? Center(child: CircularProgressIndicator())
                : data != null
                    ? ListView.builder(
                        itemBuilder: (context, index) {
                          final p = data[index];
                          return ListTile(
                            title: Text(p['post']['title']),
                            leading: Image.network(p['user']['headerUrl']),
                            subtitle: Text(p['post']['content']),
                          );
                        },
                        itemCount: data.length,
                      )
                    : Center(
                        child: Text("No User Object"),
                      )));
  }
}
