import 'package:petcom/screens/Breeder/pet_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

//TODO: ERROR network
class PetCategoryDisplay extends StatefulWidget {
  PetCategoryDisplay({
    Key? key,
  }) : super(key: key);

  @override
  _PetCategoryDisplayPageState createState() => _PetCategoryDisplayPageState();
}

class _PetCategoryDisplayPageState extends State<PetCategoryDisplay> {
  // http request
  late HttpService http;
  // json to dart
  BreederResponse? data;
  List<Breeder> _breeder = <Breeder>[];
  // helper
  bool _isLoading = false;
  bool _hasMore = false;

  int? _statusCode;
  int? _nextPage;
  int? _currentPage;
  int? _totalPage;
  ScrollController _scrollController = new ScrollController();

  //fetch a list of breeder from page i
  Future getBreeder(_currentPage) async {
    Response response;
    try {
      _isLoading = true;
      response = await http
          .getRequest("/api/breeder?current=" + _currentPage.toString());
      // if (response.data['code'] == '200') {}
      setState(() {
        data = BreederResponse.fromJson(jsonDecode(response.data));
        _breeder += data!.breeder!;
        // 200: success
        // 204: exceed the total numebr of page
        this._statusCode = data!.code!;
        this._totalPage = data!.totalPage!;
        this._currentPage = data!.currentPage!;
        this._nextPage = this._currentPage! + 1;
      });
      _isLoading = false;
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  Future sleep1() {
    return new Future.delayed(const Duration(seconds: 1), () => "1");
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getBreeder(1);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //if we are at bottom of page
        this._isLoading = true;
        sleep1();
        if (this._nextPage! > this._totalPage!) {
          _hasMore = false;
        } else {
          getBreeder(this._nextPage);
        }
        print("current page: " + this._nextPage.toString());
        this._isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Container(
          child: _isLoading
              ? Center(
                  child: Center(
                    child: SizedBox(
                      child: CircularProgressIndicator(),
                      height: 24,
                      width: 24,
                    ),
                  ),
                )
              : ListView.builder(
                  controller: _scrollController,
                  physics: BouncingScrollPhysics(),
                  itemCount: _breeder.length, // data['breeder] == _pairList
                  itemBuilder: (context, index) {
                    return AnimationConfiguration.staggeredList(
                      position: index,
                      child: SlideAnimation(
                        verticalOffset: 20.0,
                        child: ScaleAnimation(
                          child: PetCard(
                            id: _breeder[index].id,
                            title: _breeder[index].title,
                            score: _breeder[index].score,
                            type: _breeder[index].type,
                            description: _breeder[index].description,
                            createTime: _breeder[index].createTime.toString(),
                            address: _breeder[index].address,
                            city: _breeder[index].city,
                            state: _breeder[index].state,
                            contact: _breeder[index].contact,
                            website: _breeder[index].website,
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
