import 'package:flutter/material.dart';
import 'package:petcom/screens/Account/Profile/components/breeder_form.dart';
import 'package:petcom/screens/Account/Profile/components/experience_form.dart';
import 'package:petcom/screens/Account/Profile/components/profile_pic.dart';
import 'profile_menu.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Submit a Breeder/Shelter",
            press: () {
              Navigator.pushNamed(context, BreederFormScreen.routeName);
            },
          ),
          ProfileMenu(
            text: "Share your experience",
            press: () {
              Navigator.pushNamed(context, ExperienceFormScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}
