import 'package:flutter/widgets.dart';
import 'package:petcom/screens/Account/Profile/components/breeder_form.dart';
import 'package:petcom/screens/Account/Profile/components/experience_form.dart';
import 'package:petcom/screens/Account/Profile/profile_screen.dart';
import 'package:petcom/screens/Article/article_list_screen.dart';
import 'package:petcom/screens/Breeder/drawer_screen.dart';
import 'package:petcom/screens/Breeder/pet_screen.dart';
import 'package:petcom/screens/Home/home_screen.dart';
import 'package:petcom/screens/main_screen.dart';

final Map<String, WidgetBuilder> routes = {
  MainScreen.routeName: (context) => MainScreen(),
  // Home
  HomeScreen.routeName: (context) => HomeScreen(),

  // Article
  ArticleList.routeName: (context) => ArticleList(),
  // Breeder
  PetScreen.routeName: (context) => PetScreen(),
  DrawerScreen.routeName: (context) => DrawerScreen(),
  // Profile
  ProfileScreen.routeName: (context) => ProfileScreen(),
  BreederFormScreen.routeName: (context) => BreederFormScreen(),
  ExperienceFormScreen.routeName: (context) => ExperienceFormScreen()
};
