import 'package:petcom/components/pet_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:loadmore/loadmore.dart';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import '../configuration.dart';

class PetCategoryDisplay extends StatefulWidget {
  PetCategoryDisplay({
    Key? key,
  }) : super(key: key);

  @override
  _PetCategoryDisplayPageState createState() => _PetCategoryDisplayPageState();
}

class _PetCategoryDisplayPageState extends State<PetCategoryDisplay> {
  late HttpService http;
  BreederList? breederList;

  bool isLoading = false;
  int currentPage = 1;
  dynamic data;

  Future getBreeder(_currentPage) async {
    Response response;
    try {
      isLoading = true;
      response = await http
          .getRequest("/api/breeder?current=" + _currentPage.toString());
      // if (response.data['code'] == '200') {}
      setState(() {
        data = json.decode(response.data);
        print(data);
      });
      isLoading = false;
    } on Exception catch (e) {
      isLoading = false;
      print(e);
    }
  }

  @override
  void initState() {
    http = HttpService();
    getBreeder(currentPage);
    super.initState();
  }

  //TODO: GET Request to /api/breeder
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Container(
          child: isLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: data['breeder'].length,
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        verticalOffset: 50.0,
                        child: ScaleAnimation(
                          child: PetCard(
                            id: breeder[index]['id'],
                            title: breeder[index]['title'],
                            score: breeder[index]['score'],
                            type: breeder[index]['type'],
                            description: breeder[index]['description'],
                            createTime: breeder[index]['create_time'],
                            address: breeder[index]['address'],
                            city: breeder[index]['city'],
                            state: breeder[index]['state'],
                            contact: breeder[index]['contact'],
                            website: breeder[index]['website'],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
