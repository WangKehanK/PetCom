import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  static String routeName = "/drawer";

  DrawerScreen({Key key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("Drawer Filter"),
    );
  }
}
