import 'package:petcom/constants.dart';
import 'package:flutter/material.dart';

class TwoSideRoundedButton extends StatelessWidget {
  final String? text;
  final double radious;
  const TwoSideRoundedButton({
    Key? key,
    this.text,
    this.radious = 29,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(radious),
            bottomRight: Radius.circular(radious),
          ),
        ),
        child: RichText(
          maxLines: 2,
          text: TextSpan(
            style: TextStyle(color: kBlackColor),
            children: [
              TextSpan(
                text: text!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
