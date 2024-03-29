import 'package:flutter/widgets.dart';
import 'package:petcom/screens/Account/Profile/components/breeder_form.dart';
import 'package:petcom/screens/Account/Profile/components/experience_form.dart';
import 'package:petcom/screens/Account/Profile/components/ok.dart';
import 'package:petcom/screens/Account/Profile/profile_screen.dart';
import 'package:petcom/screens/Article/article_list_screen.dart';
import 'package:petcom/screens/Breeder/pet_screen.dart';
import 'package:petcom/screens/Home/home_screen.dart';
import 'package:petcom/screens/Search/search_result.dart';
import 'package:petcom/screens/main_screen.dart';

final Map<String, WidgetBuilder> routes = {
  MainScreen.routeName: (context) => MainScreen(),
  // Home
  HomeScreen.routeName: (context) => HomeScreen(),

  // Article
  ArticleScreen.routeName: (context) => ArticleScreen(),
  // Breeder
  PetScreen.routeName: (context) => PetScreen(),
  // Profile
  ProfileScreen.routeName: (context) => ProfileScreen(),
  BreederFormScreen.routeName: (context) => BreederFormScreen(),
  ExperienceFormScreen.routeName: (context) => ExperienceFormScreen(),
  OKScreen.routeName: (context) => OKScreen(),
  // Seach
  SearchResultScreen.routeName: (context) => SearchResultScreen(
        searchText: '',
        type: 0,
      ),
};
