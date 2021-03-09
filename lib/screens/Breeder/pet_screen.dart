import 'package:petcom/configuration.dart';
import 'package:petcom/components/pet_category_display.dart';
import 'package:petcom/components/search_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:petcom/screens/Breeder/drawer_screen.dart';

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
                IconButton(
                    icon: Icon(CupertinoIcons.slider_horizontal_3),
                    onPressed: () {
                      Navigator.pushNamed(context, DrawerScreen.routeName);
                    }),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '  Location',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_pin,
                          color: primaryGreen,
                          size: 16,
                        ),
                        // Text('Hello'),
                        RichText(
                          text: TextSpan(
                            text: 'MA',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
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
