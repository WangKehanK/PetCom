import 'package:flutter/material.dart';
import 'package:petcom/model/DiscussPostModel.dart';
import 'package:petcom/utils/api.dart';

class Trending extends StatefulWidget {
  Trending({
    Key key,
  }) : super(key: key);

  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<Trending> {
  List<DiscussPost> posts = [];

  @override
  Widget build(BuildContext context) {
    getPost();
    return Container(
        child: Center(
      child: Text('Trending'),
    ));
  }
}
// class Trending extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         child: Center(
//       child: Text('Trending'),
//     ));
//   }
// }
