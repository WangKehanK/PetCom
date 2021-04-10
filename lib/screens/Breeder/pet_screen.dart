import 'package:petcom/constants.dart';
import 'package:petcom/screens/Breeder/components/pet_category_display.dart';
import 'package:petcom/screens/Breeder/components/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PetScreen extends StatefulWidget {
  static String routeName = "/breeder";

  PetScreen({Key? key}) : super(key: key);

  @override
  _PetScreenState createState() => _PetScreenState();
}

class _PetScreenState extends State<PetScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(
                      child: Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: 'Where you can get your pet',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: kWhiteColor,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          SearchBar(),
          SizedBox(
            height: 20,
          ),
          PetCategoryDisplay(),
        ],
      ),
    );
  }
}
