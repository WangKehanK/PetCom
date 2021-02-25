import 'package:flutter/material.dart';
import 'package:petcom/pages/main_screen.dart';
import 'package:petcom/pages/welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MainTheme());
}

class MainTheme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'PetCom',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: WelcomeScreen(),
        routes: {
          MainScreen.routeName: (ctx) => MainScreen(),
        },
        onUnknownRoute: (settings) {
          return MaterialPageRoute(
            builder: (ctx) => MainScreen(),
          );
        });
  }
}
