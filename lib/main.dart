import 'package:flutter/material.dart';
import 'package:petcom/screens/main_screen.dart';
import 'package:petcom/routes.dart';
import 'package:petcom/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: theme(),
      // home: SplashScreen(),
      // We use routeName so that we dont need to remember the name
      initialRoute: MainScreen.routeName,
      routes: routes,
    );
  }
}