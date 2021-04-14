import 'dart:math';
import 'package:petcom/components/rating.dart';
import 'package:petcom/screens/Breeder/components/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:petcom/util.dart';

import 'package:petcom/constants.dart';

// ignore: must_be_immutable
class PetCard extends StatelessWidget {
  int? id = 0;
  String? title = "Unknown";
  int? score = 0;
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

  Random _random = new Random();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return DetailsScreen(
                id: id.toString(),
                color: randomColor(),
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
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                            ],
                          ),
                          Text(
                            address == null
                                ? "Unknown"
                                : getType(type.toString()),
                            style: TextStyle(
                              fontSize: 12,
                              color: fadedBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state == null ? "Unknown" : "Location: $state",
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
            Container(
              width: size.width * 0.48,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: randomColor(),
                      boxShadow: customShadow,
                      // borderRadius: BorderRadius.circular(22),
                    ),
                    margin: EdgeInsets.only(top: 50),
                  ),
                  Align(
                    child: Hero(
                      tag: id.toString(),
                      child: Image.asset(
                        imagePaths[_random.nextInt(imagePaths.length)],
                      ),
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
