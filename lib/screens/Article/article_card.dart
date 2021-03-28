import 'dart:math';
import 'package:petcom/components/rating.dart';
import 'package:petcom/screens/Breeder/details_screen.dart';
import 'package:flutter/material.dart';

import '../../configuration.dart';
import 'package:petcom/constants.dart';

class ArticleCard extends StatelessWidget {
  int? id = 0;
  String? title = "Unknown";
  DateTime? creatTime;
  // double? score = 0.0;
  // int? type = 0;
  // String? description = "Unknown";
  // String? createTime = "Unknown";
  // String? address = "Unknown";
  // String? city = "Unknown";
  // String? state = "Unknown";
  // String? contact = "Unknown";
  // String? website = "Unknown";
  ArticleCard({
    this.id,
    this.title,
    this.creatTime,
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
    final size = MediaQuery.of(context).size;
    final randomColor = colors[_random.nextInt(colors.length)];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                id: '1',
                color: randomColor,
              );
            },
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Container(
          // margin: EdgeInsets.symmetric(horizontal: 20),
          // height: 240,
          child: Stack(
            children: [
              Container(
                // margin: EdgeInsets.only(
                //   top: 100,
                //   bottom: 20,
                // ),
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
                                    title!,
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
                              "$creatTime!",
                              style: TextStyle(
                                fontSize: 10,
                                color: fadedBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "First few words...",
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
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
