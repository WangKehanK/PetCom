import 'package:flutter/material.dart';

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: 500,
      child: Stack(
        fit: StackFit.expand,
        children: [
          FittedBox(
            child: Image.asset(
              "assets/images/logo.png",
            ),
            fit: BoxFit.contain,
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
            ),
          )
        ],
      ),
    );
  }
}
