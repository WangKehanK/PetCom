import 'package:flutter/material.dart';
import 'package:petcom/constants.dart';

class OKScreen extends StatelessWidget {
  static String routeName = "/ok";
  const OKScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        width: double.infinity,
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: new Text(
                'Information has been recorded! Thanks for your contribution! We will verify them and post it to our platform.',
                // softWrap: true,
                style: new TextStyle(fontSize: 17.0, color: Colors.black),
              ),
            ),
            new TextButton(
              style: TextButton.styleFrom(
                primary: kWhiteColor,
                backgroundColor: Colors.orange[500],
                onSurface: Colors.grey,
                padding: EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: new Text(
                "OK!",
                style: new TextStyle(fontSize: 20.0, color: Colors.white),
              ),
              onPressed: () {
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 3);
              },
            ),
          ],
        ),
      ),
    );
  }
}
