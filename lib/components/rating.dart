import 'package:petcom/constants.dart';
import 'package:flutter/material.dart';

class Rating extends StatelessWidget {
  final int? score;
  const Rating({
    Key? key,
    this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            offset: Offset(3, 7),
            blurRadius: 20,
            color: Color(0xFD3D3D3).withOpacity(.5),
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          Icon(
            Icons.visibility_rounded,
            color: kShadowColor,
            size: 15,
          ),
          SizedBox(height: 5),
          Text(
            score == null ? "*" : "$score",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
