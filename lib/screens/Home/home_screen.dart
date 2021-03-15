import 'package:petcom/components/search_bar.dart';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/screens/Breeder/details_screen.dart';
import 'package:petcom/components/reading_card_list.dart';
import 'package:flutter/material.dart';
import 'package:petcom/constants.dart';
import 'package:petcom/components/rating.dart';
import 'package:petcom/components/two_side_rounded_button.dart';
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

                  buildTitle(context, "Featured ", "Article"),
                  Text("Something here"),
                  buildTitle(context, "Recommend ", "Owners"),
                  SizedBox(height: 30),
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

  Padding buildTitle(BuildContext context, String s1, String s2) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: () {
          print("direct!");
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
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
