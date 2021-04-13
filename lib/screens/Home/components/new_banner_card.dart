import 'package:flutter/material.dart';
import 'package:petcom/screens/Article/components/article_detail_screen.dart';
import 'package:petcom/util.dart';
import '../../../constants.dart';

// ignore: must_be_immutable
class NewBannerCard extends StatelessWidget {
  int? commentCount;
  String? content;
  int? createTime;
  String? id;
  int? score;
  int? status;
  String? title;
  int? type;
  int? userId;
  String? imagePath = "assets/images/banner1.png";

  NewBannerCard({
    this.commentCount,
    this.content,
    this.createTime,
    this.id,
    this.score,
    this.status,
    this.title,
    this.type,
    this.userId,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () =>
          Navigator.push(context, MaterialPageRoute(builder: (context) {
        return ArticleDetailsScreen(
          id: id,
          color: randomColor(),
        );
      })),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 10),
              blurRadius: 10,
              color: Color(0xFFEAEAEA).withOpacity(1),
            ),
          ],
        ),
        margin: EdgeInsets.only(
          left: kDefaultPadding,
          top: kDefaultPadding / 2,
          bottom: kDefaultPadding * 1.3,
        ),
        width: size.width * 0.4,
        child: Column(
          children: <Widget>[
            Image.asset(imagePath!),
            Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    maxLines: 2,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "$title\n",
                            style: Theme.of(context).textTheme.button),
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
}
