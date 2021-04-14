import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:petcom/constants.dart';
import 'package:dio/dio.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:direct_select/direct_select.dart';
import 'package:petcom/model/Breeder.dart';
import 'package:petcom/service/http_serivce.dart';

class ExperienceFormScreen extends StatefulWidget {
  static String routeName = "/experience_form";

  @override
  State<StatefulWidget> createState() {
    return ExperienceFormScreenState();
  }
}

class ExperienceFormScreenState extends State<ExperienceFormScreen> {
  var dio = Dio();
  String? _name;
  String? _description;

  // http request
  late HttpService http;
  List<String> _breederNames = [
    "None",
  ];
  BreederNameList? _breederNameList;
  // helper
  bool _isLoading = false;

  Future getBreederName() async {
    Response response;
    try {
      _isLoading = true;
      response = await http.getRequest("/api/breeder/name");
      _breederNameList = BreederNameList.fromJson(jsonDecode(response.data));
      print(_breederNameList);
      if (_breederNameList!.code == 200) {
        setState(() {
          _breederNames += _breederNameList!.breeder!;
          _isLoading = false;
        });
      }
    } on Exception catch (e) {
      _isLoading = false;
      print(e);
    }
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderSide: new BorderSide(),
        ),
      ),
      maxLength: 50,
      maxLines: 1,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'You have to give a title for your experience/article';
        }
        return null;
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  Widget _buildDescription() {
    return TextFormField(
      maxLines: 3,
      maxLength: 400,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          borderSide: new BorderSide(),
        ),
      ),
      keyboardType: TextInputType.multiline,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'You cannot submit empty experience/article';
        }
        return null;
      },
      onSaved: (String? value) {
        _description = value;
      },
    );
  }

  @override
  void initState() {
    super.initState();
    http = HttpService();
    getBreederName();
  }

  int _category = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> _items = _breederNames
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
    return Scaffold(
      appBar: AppBar(title: Text("Share your experience")),
      body: _isLoading
          ? Center(
              child: Center(
                child: SizedBox(
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.all(24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      buildTitle(context, "Title*"),
                      _buildName(),
                                      Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            RichText(
              maxLines: 2,
              text: TextSpan(
                style: Theme.of(context).textTheme.headline5,
                children: [
                  TextSpan(text: "Find shelter/breeder"),
                                  TextSpan(text: "(long press)",style: TextStyle(
                  fontSize: 10,
                ),),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
                      DirectSelect(
                          itemExtent: 50.0,
                          selectedIndex: _category,
                          backgroundColor: Colors.white,
                          child: MySelectionItem(
                            isForList: false,
                            title: this._breederNames[_category],
                          ),
                          onSelectedItemChanged: (index) {
                            setState(() {
                              _category = index!;
                            });
                          },
                          items: _items),
                      buildTitle(context, "Your Experience*"),
                      _buildDescription(),
                      SizedBox(height: 50),
                      TextButton(
                        style: TextButton.styleFrom(
                          primary: kWhiteColor,
                          backgroundColor: Colors.orange[400],
                          onSurface: Colors.grey,
                          padding: EdgeInsets.all(20),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: kWhiteColor, fontSize: 16),
                        ),
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) {
                            return;
                          }

                          _formKey.currentState!.save();
                          _description =
                              "This is experience/article about ${_breederNames[_category]}. $_description";
                          var params = {
                            "title": _name,
                            "content": _description,
                          };
                          //Send to API
                          Dialogs.materialDialog(
                              msg:
                                  'Are you sure ? The information will be submitted',
                              title: "Submit",
                              color: Colors.white,
                              context: context,
                              actions: [
                                IconsOutlineButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  text: 'Cancel',
                                  iconData: Icons.cancel_outlined,
                                  textStyle: TextStyle(color: Colors.grey),
                                  iconColor: Colors.grey,
                                ),
                                IconsButton(
                                  onPressed: () async {
                                    await dio.post(
                                        "${HttpService().baseUrl}/api/article/add",
                                        data: params);
                                    int count = 0;
                                    Navigator.of(context)
                                        .popUntil((_) => count++ >= 2);
                                  },
                                  text: 'Submit',
                                  iconData: Icons.arrow_forward_ios_sharp,
                                  color: Colors.orange[400],
                                  textStyle: TextStyle(color: Colors.white),
                                  iconColor: Colors.white,
                                ),
                              ]);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Padding buildTitle(BuildContext context, String s1) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Row(
          children: <Widget>[
            RichText(
              maxLines: 2,
              text: TextSpan(
                style: Theme.of(context).textTheme.headline5,
                children: [
                  TextSpan(text: s1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySelectionItem extends StatelessWidget {
  final String title;
  final bool isForList;

  const MySelectionItem({Key? key, required this.title, this.isForList = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: isForList
          ? Padding(
              child: _buildItem(context),
              padding: EdgeInsets.all(10.0),
            )
          : Card(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: Stack(
                children: <Widget>[
                  _buildItem(context),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Icon(Icons.arrow_drop_down),
                  )
                ],
              ),
            ),
    );
  }

  _buildItem(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text(title),
    );
  }
}
