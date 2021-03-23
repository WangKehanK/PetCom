import 'package:flutter/material.dart';

final primaryGreen = Color(0xff416d6d);
final secondaryGreen = Color(0xff16a085);
final fadedBlack = Colors.black.withAlpha(150);
final kPrimaryColor = Color(0xFFF9A825);
const kPrimaryLightColor = Color(0xFFFFF8E1);
final kWhiteColor = Colors.white;
final kBlackColor = Color(0xFF393939);
final kLightBlackColor = Color(0xFF8F8F8F);
final kIconColor = Color(0xFFF48A37);
final kProgressIndicator = Color(0xFFBE7066);
final kTextColor = Color(0xFF757575);
final kShadowColor = Color(0xFFD3D3D3).withOpacity(.84);

const defaultDuration = Duration(milliseconds: 250);

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
