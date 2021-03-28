import 'package:petcom/constants.dart';
import 'package:petcom/components/rating.dart';
import 'package:petcom/components/two_side_rounded_button.dart';
import 'package:flutter/material.dart';

class SquareBannerCard extends StatelessWidget {
  final String? image;
  final String? title;
  final double? rating;
  final Function? pressDetails;
  final Function? pressRead;

  const SquareBannerCard({
    Key? key,
    this.image,
    this.title,
    this.rating,
    this.pressDetails,
    this.pressRead,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 15),
            blurRadius: 10,
            color: Color(0xFFEAEAEA).withOpacity(1),
          ),
        ],
      ),
      margin: EdgeInsets.only(left: 24, bottom: 40),
      height: 245,
      width: 202,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 221,
              decoration: BoxDecoration(
                color: kWhiteColor,
              ),
            ),
          ),
          Image.asset(
            image!,
            width: 150,
          ),
          Positioned(
            top: 35,
            right: 10,
            child: Column(
              children: <Widget>[
                // IconButton(
                //   icon: Icon(
                //     Icons.favorite_border,
                //   ),
                //   onPressed: () {},
                // ),
                Rating(score: rating),
              ],
            ),
          ),
          Positioned(
            top: 160,
            child: Container(
              height: 85,
              width: 202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(color: kBlackColor),
                        children: [
                          TextSpan(
                            text: "$title\n",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "",
                            style: TextStyle(
                              color: kLightBlackColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        child: Container(
                          width: 101,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          alignment: Alignment.center,
                          child: Text(""),
                        ),
                      ),
                      Expanded(
                        child: TwoSideRoundedButton(
                          radious: 0,
                          text: "Detail",
                          press: pressDetails,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
