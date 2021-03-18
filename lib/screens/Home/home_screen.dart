import 'package:petcom/components/article_card.dart';
import 'package:petcom/components/search_bar.dart';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/screens/Article/article_list_screen.dart';
import 'package:petcom/screens/Breeder/details_screen.dart';
import 'package:petcom/components/reading_card_list.dart';
import 'package:flutter/material.dart';
import 'package:petcom/screens/Breeder/pet_screen.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';
import 'dart:math';
import 'package:petcom/configuration.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = "/index";

  HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HttpService? http;
  BreederList? breederList;

  Future getBreeder() async {
    Response response;
  }

  // @override
  // void initState {
  //   http = HttpService();
  //   getBreeder();
  //   super.initState();
  // }
  Random _random = new Random();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: size.height * .05),
                  SearchBar(),
                  SizedBox(height: size.height * .04),

                  buildTitleWithPush(
                      context, "Featured ", "Article", ArticleList.routeName),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        ArticleCard(
                          size: size,
                        ),
                        ArticleCard(
                          size: size,
                        ),
                        ArticleCard(
                          size: size,
                        ),
                      ],
                    ),
                  ),
                  //TODO Update link
                  buildTitle(context, "Recommend ", "Owners"),
                  // SizedBox(height: 30),

                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        ReadingListCard(
                          image: "assets/images/cat-1.png",
                          title: "Sunshine Kitten House",
                          auth: "",
                          rating: 4.9,
                          pressDetails: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return DetailsScreen();
                                },
                              ),
                            );
                          },
                        ),
                        ReadingListCard(
                          image: "assets/images/cat-1.png",
                          title: "Sunshine Puppy House",
                          auth: "",
                          rating: 4.8,
                        ),
                        ReadingListCard(
                          image: "assets/images/cat-1.png",
                          title: "Sunshine Puppy House",
                          auth: "",
                          rating: 4.8,
                        ),
                        SizedBox(width: 30),
                      ],
                    ),
                  ),
                  // bestOfTheDayCard(size, context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Padding buildTitleWithPush(
      BuildContext context, String s1, String s2, String routeName) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: () {
          try {
            Navigator.pushNamed(context, routeName);
          } on Exception catch (e) {
            print(e);
          }
        },
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline5,
                children: [
                  TextSpan(text: s1),
                  TextSpan(
                    text: s2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(width: 60),
            Container(
              child: (routeName == '')
                  ? Icon(Icons.pets)
                  : Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Padding buildTitle(BuildContext context, String s1, String s2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        child: Row(
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline5,
                children: [
                  TextSpan(text: s1),
                  TextSpan(
                    text: s2,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  // Container bestOfTheDayCard(Size size, BuildContext context) {
  //   return Container(
  //     margin: EdgeInsets.only(left: 24, bottom: 40),
  //     width: 300,
  //     height: 245,
  //     child: Stack(
  //       children: <Widget>[
  //         Positioned(
  //           bottom: 0,
  //           left: 0,
  //           right: 0,
  //           child: Container(
  //             padding: EdgeInsets.only(
  //               left: 24,
  //               top: 24,
  //               right: size.width * .35,
  //             ),
  //             height: 230,
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //               color: Color(0xFFEAEAEA).withOpacity(.45),
  //               borderRadius: BorderRadius.circular(29),
  //             ),
  //             child: Column(
  //               crossAxisAlignment: CrossAxisAlignment.start,
  //               children: <Widget>[
  //                 Container(
  //                   margin: EdgeInsets.only(top: 10.0, bottom: 10.0),
  //                   child: Text(
  //                     "New York Time Best For 11th March 2020",
  //                     style: TextStyle(
  //                       fontSize: 9,
  //                       color: kLightBlackColor,
  //                     ),
  //                   ),
  //                 ),
  //                 Text(
  //                   "How To Win \nFriends &  Influence",
  //                   style: Theme.of(context).textTheme.title,
  //                 ),
  //                 Text(
  //                   "Gary Venchuk",
  //                   style: TextStyle(color: kLightBlackColor),
  //                 ),
  //                 Padding(
  //                   padding: EdgeInsets.only(top: 10, bottom: 10.0),
  //                   child: Row(
  //                     children: <Widget>[
  //                       Padding(
  //                         padding: EdgeInsets.only(right: 10.0),
  //                         child: Rating(score: 4.9),
  //                       ),
  //                       Expanded(
  //                         child: Text(
  //                           "When the earth was flat and everyone wanted to win the game of the best and people….",
  //                           maxLines: 3,
  //                           overflow: TextOverflow.ellipsis,
  //                           style: TextStyle(
  //                             fontSize: 10,
  //                             color: kLightBlackColor,
  //                           ),
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           right: 0,
  //           top: 0,
  //           child: Image.asset(
  //             "assets/images/dog10.png",
  //             width: size.width * .37,
  //           ),
  //         ),
  //         Positioned(
  //           bottom: 0,
  //           right: 0,
  //           child: SizedBox(
  //             height: 40,
  //             width: size.width * .3,
  //             child: TwoSideRoundedButton(
  //               text: "Read",
  //               radious: 24,
  //               press: () {},
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}
