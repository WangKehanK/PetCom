import 'package:petcom/configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ArticleDetailsScreen extends StatefulWidget {
  String? id;
  String? title;
  Color? color;
  ArticleDetailsScreen({this.id, this.title, this.color});

  @override
  _ArticleDetailsScreenState createState() => _ArticleDetailsScreenState();
}

class _ArticleDetailsScreenState extends State<ArticleDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: getBody(),
    );
  }

  Widget getBody() {
    String? petName = '';
    String? breed = '';
    String? age = '';
    String? gender = '';
    String? imagePath = '';
    dogs.forEach((dog) {
      if (dog['id'] == widget.id) {
        petName = dog['name'];
        breed = dog['breed'];
        age = dog['age'];
        gender = dog['gender'];
        imagePath = dog['imagePath'];
      }
    });
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(imagePath!), fit: BoxFit.contain),
              color: widget.color,
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    // buildAppbar(context),
                    InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          print("success");
                        },
                        child: IconButton(
                          icon: Icon(
                            CupertinoIcons.chevron_left,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        )),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: size.height * 0.45),
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(50)),
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Align(
                  //   child: Container(
                  //     width: 150,
                  //     height: 7,
                  //     decoration: BoxDecoration(
                  //         color: Colors.red[50],
                  //         borderRadius: BorderRadius.circular(10)),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  Text(
                    "10 best interior ideas for your\nliving room",
                    style: TextStyle(fontSize: 20, height: 1.5),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage(
                                    "https://images.nowcoder.com/head/108m.png"),
                                fit: BoxFit.cover)),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            petName!,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Shelter",
                            style: TextStyle(fontSize: 13),
                          )
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("Contact"),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("Instagram"),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Text("Something else"),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Nobody wants to stare at a blank wall all day long, which is why wall art is such a crucial step in the decorating process. And once you start brainstorming, the rest is easy. From gallery walls to DIY pieces like framing your accessories and large-scale photography, we've got plenty of wall art ideas to spark your creativity. And where better to look for inspiration that interior designer-decorated walls",
                    style: TextStyle(height: 1.6),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Gallery",
                    style: TextStyle(fontSize: 18),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage("assets/images/dog0.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage("assets/images/dog1.png"),
                                    fit: BoxFit.cover)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20),
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image: AssetImage("assets/images/dog2.png"),
                                    fit: BoxFit.cover)),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
