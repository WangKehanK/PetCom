import 'package:flutter/material.dart';
import 'package:petcom/screens/Home/home_screen.dart';
import 'package:petcom/screens/Breeder/pet_screen.dart';
import 'package:petcom/screens/Account/Profile/profile_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants.dart';

class MainScreen extends StatefulWidget {
  static String routeName = '/main_screen';
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: IndexedStack(
        children: <Widget>[
          HomeScreen(),
          PetScreen(),
          ProfileScreen(),
        ],
        index: _selectedPageIndex,
      ),
      bottomNavigationBar: Stack(
        children: [
          Container(
            width: size.width,
            height: 80,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(size.width, 80),
                  painter: BNBCustomPainter(),
                ),
                Center(
                  heightFactor: 0.6,
                  child: FloatingActionButton(
                      backgroundColor: _selectedPageIndex == 0
                          ? Colors.grey.shade400
                          : Colors.brown,
                      child: Icon(Icons.pets),
                      elevation: 0.1,
                      onPressed: () {
                        _selectPage(1);
                      }),
                ),
                Container(
                  width: size.width,
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.home,
                          color: _selectedPageIndex == 0
                              ? Colors.brown
                              : Colors.grey.shade400,
                        ),
                        onPressed: () {
                          _selectPage(0);
                        },
                      ),
                      Container(
                        width: size.width * 0.20,
                      ),
                      IconButton(
                          icon: Icon(
                            Icons.person_sharp,
                            color: _selectedPageIndex == 2
                                ? Colors.brown
                                : Colors.grey.shade400,
                          ),
                          onPressed: () {
                            _selectPage(2);
                          }),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = kWhiteColor
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 20);
    path.arcToPoint(Offset(size.width * 0.60, 20),
        radius: Radius.circular(20.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path.shift(Offset(0, -5)), Colors.black, 10, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
