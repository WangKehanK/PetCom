import 'package:flutter/material.dart';

class HeaderLine extends StatelessWidget {
  const HeaderLine({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(child: headerLine(context));
  }

  Container headerLine(BuildContext context) {
    return Container(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            RichText(
              text: TextSpan(
                style: Theme.of(context).textTheme.headline4,
                children: [
                  TextSpan(text: "Best of the "),
                  TextSpan(
                    text: "day",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
