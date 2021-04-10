import 'package:petcom/constants.dart';
import 'package:petcom/screens/Breeder/components/pet_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/service/http_serivce.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

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
  BreederResponse? _breederResponse;
  List<Breeder> _breeder = <Breeder>[];
  // helper
  bool _isLoading = false;
  bool _hasMore = true;

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
          .getRequest("/api/breeder/all?current=" + _currentPage.toString());
      _breederResponse = BreederResponse.fromJson(jsonDecode(response.data));
      if (_breederResponse!.code == 200) {
        setState(() {
          _breeder += _breederResponse!.breeder!;
          // 200: success
          // 204: exceed the total numebr of page
          this._totalPage = _breederResponse!.totalPage!;
          this._currentPage = _breederResponse!.currentPage!;
          this._nextPage = this._currentPage! + 1;
        });
        _isLoading = false;
      }
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  Future loadMore() async {
    getBreeder(1);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        //if we are at bottom of page
        this._isLoading = true;
        sleep1();
        print("next page: " + this._nextPage.toString());
        if (this._nextPage! > this._totalPage!) {
          setState(() {
            _hasMore = false;
          });
        } else {
          getBreeder(this._nextPage);
          setState(() {
            _hasMore = true;
          });
        }
        print("current page: " + this._nextPage.toString());
        this._isLoading = false;
      }
    });
  }

  Future _refreshData() async {
    await sleep1();
    _breeder.clear();
    loadMore();
    setState(() {});
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
    http = HttpService();
    loadMore();
    super.initState();
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
                    ),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: _refreshData,
                  child: ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        Divider(
                      height: 16.0,
                      color: kPrimaryLightColor,
                    ),
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: _breeder.length + 1,
                    itemBuilder: (context, index) {
                      if (index < _breeder.length) {
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: ScaleAnimation(
                              child: PetCard(
                                id: _breeder[index].id,
                                title: _breeder[index].title,
                                score: _breeder[index].score,
                                type: _breeder[index].type,
                                description: _breeder[index].description,
                                createTime:
                                    _breeder[index].createTime.toString(),
                                address: _breeder[index].address,
                                city: _breeder[index].city,
                                state: _breeder[index].state,
                                contact: _breeder[index].contact,
                                website: _breeder[index].website,
                              ),
                            ),
                          ),
                        );
                      } else if (_hasMore) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (!_hasMore) {
                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 32.0),
                          child: Center(child: Text('nothing more to load!')),
                        );
                      } else {
                        return Container(child: Text("heelo"));
                      }
                    },
                  ),
                ),
        ),
      ),
    );
  }
}
