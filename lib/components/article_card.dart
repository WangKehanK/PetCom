import 'package:flutter/material.dart';
import 'package:petcom/constants.dart';
import 'package:petcom/components/rating.dart';
import 'package:petcom/components/two_side_rounded_button.dart';
import 'dart:math';
import 'package:petcom/screens/Article/article_detail_screen.dart';
import '../configuration.dart';

class ArticleCard extends StatelessWidget {
  Size? size;
  int? id = 0;
  String? title = "Unknown";
  double? score = 0.0;
  int? type = 0;
  String? description = "Unknown";
  String? createTime = "Unknown";
  String? address = "Unknown";
  String? city = "Unknown";
  String? state = "Unknown";
  String? contact = "Unknown";
  String? website = "Unknown";
  ArticleCard({
    this.size,
    this.id,
    this.title,
    this.score,
    this.type,
    this.description,
    this.createTime,
    this.address,
    this.city,
    this.state,
    this.contact,
    this.website,
  });

  final colors = [
    Colors.blueGrey[200],
    Colors.green[200],
    Colors.pink[100],
    Colors.brown[200],
    Colors.lightBlue[200],
  ];

  Random _random = new Random();
  @override
  Widget build(BuildContext context) {
    final randomColor = colors[_random.nextInt(colors.length)];

    return Container(
      margin: EdgeInsets.only(left: 24, bottom: 20),
      width: 300,
      height: 215,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                left: 24,
                top: 24,
                right: size!.width * .35,
              ),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFEAEAEA).withOpacity(1),
                borderRadius: BorderRadius.circular(29),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Container(
                  //   margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  //   child: Text(
                  //     "New York Time Best For 11th March 2020",
                  //     style: TextStyle(
                  //       fontSize: 9,
                  //       color: kLightBlackColor,
                  //     ),
                  //   ),
                  // ),
                  Text(
                    "Tips to Pet Your Puppy",
                    style: Theme.of(context).textTheme.title,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "User 001",
                    style: TextStyle(
                        color: kLightBlackColor, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10.0),
                    child: Row(
                      children: <Widget>[
                        // Padding(
                        //   padding: EdgeInsets.only(right: 10.0),
                        //   child: Rating(score: 4.9),
                        // ),
                        Expanded(
                          child: Text(
                            "When the earth was flat and everyone wanted to win the game of the best and people….",
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 10,
                              color: kLightBlackColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Image.asset(
              "assets/images/dog10.png",
              width: size!.width * .37,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: SizedBox(
              height: 40,
              width: size!.width * .3,
              child: TwoSideRoundedButton(
                text: "Detail",
                radious: 24,
                press: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) {
                        return ArticleDetailsScreen(
                          id: id.toString(),
                          color: randomColor,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
