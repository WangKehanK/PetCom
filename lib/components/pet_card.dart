import 'dart:math';
import 'package:petcom/components/rating.dart';
import 'package:petcom/screens/Breeder/details_screen.dart';
import 'package:flutter/material.dart';

import '../configuration.dart';

class PetCard extends StatelessWidget {
  String petId;
  String petName = '';
  String breed = '';
  String age = '';
  String distance = '';
  String gender = '';
  String imagePath = '';

  PetCard({
    this.petId,
    this.petName,
    this.breed,
    this.age,
    this.distance,
    this.gender,
    this.imagePath,
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
                id: petId,
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
                                  petName,
                                  softWrap: true,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Rating(
                                score: 4.6,
                              ),
                            ],
                          ),
                          Text(
                            breed,
                            style: TextStyle(
                              fontSize: 12,
                              color: fadedBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'MA',
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
                      tag: petId,
                      child: Image.asset(
                        imagePath,
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
