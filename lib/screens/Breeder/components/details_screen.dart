import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:petcom/components/rating.dart';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:petcom/util.dart';

// ignore: must_be_immutable
class DetailsScreen extends StatefulWidget {
  String? id;
  Color? color;
  DetailsScreen({this.id, this.color});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late HttpService http;
  bool _isLoading = false;

  BreederResponse? _breederResponse;
  List<Breeder> _breeder = <Breeder>[];
  Future getBreederByID(String? id) async {
    Response response;
    try {
      _isLoading = true;
      response = await http.getRequest("/api/breeder?id=$id");
      _breederResponse = BreederResponse.fromJson(jsonDecode(response.data));
      if (_breederResponse!.code == 200) {
        setState(() {
          _breeder += _breederResponse!.breeder!;
        });
        _isLoading = false;
      }
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getBreederByID(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : getBody(_breeder[0]),
    );
  }

  Widget getBody(Breeder breeder) {
    var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: size.height * 0.5,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    randomPath(breeder.type)!,
                  ),
                  fit: BoxFit.contain),
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
                    Row(
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context, true);
                            },
                            child: IconButton(
                              icon: Icon(
                                CupertinoIcons.back,
                              ),
                              onPressed: () {
                                Navigator.pop(context, true);
                              },
                            )),
                      ],
                    ),
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
                  SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "Welcome to ${breeder.title}",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              "We are: ${getType(breeder.type.toString())}",
                              style: TextStyle(fontSize: 13),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Center(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.circular(3)),
                        child: Container(
                          child: GestureDetector(
                              onTap: () {
                                Dialogs.bottomMaterialDialog(
                                    msg:
                                        'This Pet Breeder/Shelter seems very popular',
                                    title: 'Nice!',
                                    context: context,
                                    actions: [
                                      IconsOutlineButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'OK!',
                                        iconData: Icons.done,
                                        textStyle:
                                            TextStyle(color: Colors.grey),
                                        iconColor: Colors.grey,
                                      ),
                                    ]);
                              },
                              child: Rating(
                                score: breeder.score,
                              )),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Information:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    new ClipboardData(text: breeder.contact));
                                Dialogs.bottomMaterialDialog(
                                    msg:
                                        'The contact information ${breeder.contact} has been copied to your clipboard',
                                    title: 'Copied!',
                                    context: context,
                                    actions: [
                                      IconsOutlineButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'OK!',
                                        iconData: Icons.done,
                                        textStyle:
                                            TextStyle(color: Colors.grey),
                                        iconColor: Colors.grey,
                                      ),
                                    ]);
                              },
                              child: Text("Contact")),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(3)),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: GestureDetector(
                              onTap: () {
                                Clipboard.setData(
                                    new ClipboardData(text: breeder.website));
                                Dialogs.bottomMaterialDialog(
                                    msg:
                                        'The official site of ${breeder.title} <${breeder.website}> has been copied to your clipboard',
                                    title: 'Copied!',
                                    context: context,
                                    actions: [
                                      IconsOutlineButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'OK!',
                                        iconData: Icons.done,
                                        textStyle:
                                            TextStyle(color: Colors.grey),
                                        iconColor: Colors.grey,
                                      ),
                                    ]);
                              },
                              child: Text("Official Website")),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Description:",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${breeder.description}",
                    style: TextStyle(height: 1.6),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Number of Views: ${breeder.score!.toString()}",
                      style: TextStyle(fontSize: 10)),
                  Text(
                      "In our database since ${DateFormat.yMMMd().format(convertDate(breeder.createTime!))}",
                      style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
