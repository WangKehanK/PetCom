import 'dart:math';
import 'package:petcom/components/rating.dart';
import 'package:petcom/screens/Breeder/details_screen.dart';
import 'package:flutter/material.dart';

import '../configuration.dart';

class PetCard extends StatelessWidget {
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
  PetCard({
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
    final size = MediaQuery.of(context).size;
    final randomColor = colors[_random.nextInt(colors.length)];
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                id: id.toString(),
                color: randomColor,
              );
            },
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        height: 240,
        child: Stack(
          children: [
            Container(
              // height: 200,
              margin: EdgeInsets.only(
                top: 70,
                bottom: 20,
              ),
              child: Row(
                children: [
                  Container(
                    width: size.width * 0.48,
                  ),
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                  ),
                                ),
                              ),
                              Rating(
                                score: score,
                              ),
                            ],
                          ),
                          Text(
                            address == null ? "Unknown" : address!,
                            style: TextStyle(
                              fontSize: 12,
                              color: fadedBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state == null ? "Unknown" : state!,
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
                color: Colors.white,
                boxShadow: customShadow,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
            ),
            Container(
              width: size.width * 0.48,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: randomColor,
                      boxShadow: customShadow,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    margin: EdgeInsets.only(top: 50),
                  ),
                  Align(
                    child: Hero(
                      tag: id.toString(),
                      //TODO: Pet Images from Google Cloud
                      child: Image.asset(
                        imagePaths[_random.nextInt(imagePaths.length)],
                      ),
                      // Container(
                      //   decoration: BoxDecoration(
                      //       image: DecorationImage(
                      //           image: NetworkImage(imagePaths[
                      //               _random.nextInt(imagePaths.length)]))),
                      // ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
