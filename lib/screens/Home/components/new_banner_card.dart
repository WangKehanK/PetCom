import 'package:flutter/material.dart';
import '../../../constants.dart';

class NewBannerCard extends StatelessWidget {
  Size? size;
  int? id = 0;
  String? title = "Unknown";
  double? score = 0.0;
  int? type = 0;
  String? description = "Unknown";
  String? createTime = "Unknown";
  String? address = "Unknown";
  String? city = "Unknown";
  String? state = "Unknown";
  String? contact = "Unknown";
  String? website = "Unknown";
  String? imagePath = "assets/images/banner1.png";
  NewBannerCard({
    this.size,
    this.id,
    this.title,
    this.score,
    this.type,
    this.description,
    this.createTime,
    this.address,
    this.city,
    this.state,
    this.contact,
    this.website,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.only(
        left: kDefaultPadding,
        top: kDefaultPadding / 2,
        bottom: kDefaultPadding * 1.3,
      ),
      width: size.width * 0.4,
      child: Column(
        children: <Widget>[
          Image.asset(imagePath!),
          GestureDetector(
            // onTap: press,
            child: Container(
              padding: EdgeInsets.all(kDefaultPadding / 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 50,
                    color: Color(0xFFEAEAEA).withOpacity(1),
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text:
                                "Tips for New Owners", //"$title\n".toUpperCase(),
                            style: Theme.of(context).textTheme.button),
                        // TextSpan(
                        //   text: "Hello", //"$country".toUpperCase(),
                        //   style: TextStyle(
                        //     color: kPrimaryColor.withOpacity(0.5),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
