import 'package:intl/intl.dart';
import 'package:petcom/model/Post.dart';
import 'package:petcom/screens/Article/components/article_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:petcom/util.dart';
import 'package:petcom/constants.dart';

// ignore: must_be_immutable
class ArticleCard extends StatelessWidget {
  int? id = 0;
  String? title = "Unknown";
  DateTime? creatTime;
  String? content;
  Post? post;
  ArticleCard({this.post});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return ArticleDetailsScreen(
                id: post!.id!.toString(),
                color: randomColor(),
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          child: Stack(
            children: [
              Container(
                child: Row(
                  children: [
                    Container(
                      width: size.width * 0.05,
                    ),
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: new Text(
                                    "${post!.title!}",
                                    softWrap: true,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: kBlackColor,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              "${DateFormat.yMMMd().format(convertDate(post!.createTime!))}",
                              style: TextStyle(
                                fontSize: 10,
                                color: fadedBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "${mediumSentence(post!.content!)}",
                              style: TextStyle(
                                fontSize: 12,
                                color: fadedBlack,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: kWhiteColor,
                  boxShadow: customShadow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
