import 'package:flutter/material.dart';

// const kPrimaryColor = Color(0xFF0C9869);
// const kTextColor = Color(0xFF3C4046);
// const kBackgroundColor = Color(0xFFF9F8FD);

final primaryGreen = Color(0xff416d6d);
final secondaryGreen = Color(0xff16a085);
final fadedBlack = Colors.black.withAlpha(150);
final kPrimaryColor = Color(0xFFF9A825);
final kPrimaryLightColor = Color(0xFFFFF8E1);
final kWhiteColor = Colors.white;
final kBlackColor = Color(0xFF393939);
final kLightBlackColor = Color(0xFF8F8F8F);
final kIconColor = Colors.orange[500];
final kProgressIndicator = Color(0xFFBE7066);
final kTextColor = Color(0xFF3C4046);
final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);
final double kDefaultPadding = 20.0;
final defaultDuration = Duration(milliseconds: 250);

List<BoxShadow> customShadow = [
  BoxShadow(
    color: Colors.grey[300]!,
    blurRadius: 30,
    offset: Offset(0, 10),
  ),
];

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please Enter your email";
const String kInvalidEmailError = "Please Enter Valid Email";
const String kPassNullError = "Please Enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
const String kNamelNullError = "Please Enter your name";
const String kPhoneNumberNullError = "Please Enter your phone number";
const String kAddressNullError = "Please Enter your address";

List<String> imagePaths = [
  "assets/images/dog1.png",
  "assets/images/dog2.png",
  "assets/images/dog4.png",
  "assets/images/dog5.png",
  "assets/images/dog6.png",
  "assets/images/dog8.png",
];

List<String> catImagePaths = [
  "assets/images/cat1.png",
  "assets/images/cat2.png",
  "assets/images/cat3.png",
  "assets/images/cat4.png",
  "assets/images/cat5.png",
];

List<String> totalPaths = [
  "assets/images/dog1.png",
  "assets/images/dog2.png",
  "assets/images/dog4.png",
  "assets/images/dog5.png",
  "assets/images/dog6.png",
  "assets/images/dog8.png",
  "assets/images/cat1.png",
  "assets/images/cat2.png",
  "assets/images/cat3.png",
  "assets/images/cat4.png",
  "assets/images/cat5.png",
];
List<String> catPaths = [
  "assets/images/cat.png",
];

List<String> dogPaths = [
  "assets/images/dog.png",
];

List<String> shelterPaths = [
  "assets/images/shelter.png",
];
