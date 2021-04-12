import 'package:petcom/constants.dart';
import 'package:petcom/components/rating.dart';
import 'package:petcom/screens/Home/components/two_side_rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:petcom/screens/Breeder/components/details_screen.dart';
import 'package:petcom/util.dart';

class SquareBannerCard extends StatefulWidget {
  final String? id;
  final String? image;
  final String? title;
  final int? rating;
  final int? type;
  const SquareBannerCard(
      {Key? key, this.id, this.image, this.title, this.rating, this.type})
      : super(key: key);

  @override
  _SquareBannerCardState createState() => _SquareBannerCardState();
}

class _SquareBannerCardState extends State<SquareBannerCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return DetailsScreen(
          id: widget.id,
          color: randomColor(),
        );
      })),
      child: Container(
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
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
                )),
            Positioned(
              bottom: 95,
              left: 0,
              right: 0,
              child: Container(
                height: 140,
                decoration: BoxDecoration(
                  color: randomColor(),
                ),
              ),
            ),
            Container(
              width: 200,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                      image: AssetImage(
                        widget.image!,
                      ),
                      fit: BoxFit.cover)),
            ),
            Positioned(
              top: 160,
              child: Container(
                height: 90,
                width: 202,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                          style: TextStyle(color: kBlackColor),
                          children: [
                            TextSpan(
                              text:
                                  "${getType(widget.type.toString())}: ${mediumSentence(widget.title!)}\n",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TwoSideRoundedButton(
                            radious: 10,
                            text: "Click for more detail",
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
      ),
    );
  }
}
