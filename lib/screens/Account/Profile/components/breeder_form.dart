import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petcom/constants.dart';
import 'package:direct_select/direct_select.dart';

class BreederFormScreen extends StatefulWidget {
  static String routeName = "/breeder_form";

  @override
  State<StatefulWidget> createState() {
    return BreederFormScreenState();
  }
}

class BreederFormScreenState extends State<BreederFormScreen> {
  String? _name;
  String? _url;
  String? _phoneNumber;
  String? _description;
  String? _city;
  String? _state;

  final elements1 = [
    "Dog Breeder",
    "Cat Breeder",
    "Shelter",
  ];

  int _category = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => MySelectionItem(
              title: val,
            ))
        .toList();
  }

  _NumberTextInputFormatter _phoneNumberFormatter =
      _NumberTextInputFormatter(1);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildName() {
    return TextFormField(
      decoration: InputDecoration(
        // labelText: 'Enter here',
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          // borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
      maxLength: 50,
      maxLines: 1,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Title is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _name = value;
      },
    );
  }

  Widget _builURL() {
    return TextFormField(
      maxLength: 100,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          // borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
      keyboardType: TextInputType.url,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'URL is Required';
        }
        return null;
      },
      onSaved: (String? value) {
        _url = value;
      },
    );
  }

  Widget _builCity() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: TextFormField(
            maxLength: 10,
            decoration: InputDecoration(
              labelText: "city",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                // borderRadius: new BorderRadius.circular(25.0),
                borderSide: new BorderSide(),
              ),
            ),
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Location is Required';
              }
              return null;
            },
            onSaved: (String? value) {
              _city = value;
            },
          ),
        ),
        Flexible(
          child: TextFormField(
            maxLength: 2,
            decoration: InputDecoration(
              labelText: "state",
              fillColor: Colors.white,
              border: new OutlineInputBorder(
                borderSide: new BorderSide(),
              ),
            ),
            keyboardType: TextInputType.name,
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Location is required';
              }
              return null;
            },
            onSaved: (String? value) {
              _state = value;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneNumber() {
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _phoneNumberFormatter,
      ],
      maxLength: 14,
      decoration: InputDecoration(
        fillColor: Colors.white,
        border: new OutlineInputBorder(
          // borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
      keyboardType: TextInputType.phone,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Phone number is Required';
        }

        return null;
      },
      onSaved: (String? value) {
        _phoneNumber = value;
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
          // borderRadius: new BorderRadius.circular(25.0),
          borderSide: new BorderSide(),
        ),
      ),
      keyboardType: TextInputType.multiline,
      validator: (String? value) {
        if (value!.isEmpty) {
          return 'Enter your description';
        }
        return null;
      },
      onSaved: (String? value) {
        _description = value;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Submit the breeder/shelter")),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                buildTitle(context, "Title"),
                _buildName(), //Title
                // SizedBox(height: 10),
                // buildTitle(context, "E"),
                // _buildEmail(),
                buildTitle(context, "Category"),
                DirectSelect(
                    itemExtent: 50.0,
                    selectedIndex: _category,
                    backgroundColor: Colors.white,
                    child: MySelectionItem(
                      isForList: false,
                      title: elements1[_category],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _category = index!;
                      });
                    },
                    items: _buildItems1()),
                // _buildPassword(),
                SizedBox(height: 15),
                buildTitle(context, "Website"),
                _builURL(),

                SizedBox(height: 10),
                buildTitle(context, "Location"),
                _builCity(),

                SizedBox(height: 10),
                buildTitle(context, "Phone"),
                _buildPhoneNumber(),

                SizedBox(height: 10),
                buildTitle(context, "Description"),
                _buildDescription(),
                SizedBox(height: 30),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: kWhiteColor,
                    backgroundColor: Colors.brown,
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
                    print(_name);
                    print(_category);
                    print(_url);
                    print(_state);
                    print(_city);
                    print(_phoneNumber);
                    print(_description);
                    //Send to API
                    // if response code == 200
                    Navigator.pop(context, true);
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

class _NumberTextInputFormatter extends TextInputFormatter {
  int _whichNumber;
  _NumberTextInputFormatter(this._whichNumber);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    switch (_whichNumber) {
      case 1:
        {
          if (newTextLength >= 1) {
            newText.write('(');
            if (newValue.selection.end >= 1) selectionIndex++;
          }
          if (newTextLength >= 4) {
            newText.write(
                newValue.text.substring(0, usedSubstringIndex = 3) + ') ');
            if (newValue.selection.end >= 3) selectionIndex += 2;
          }
          if (newTextLength >= 7) {
            newText.write(
                newValue.text.substring(3, usedSubstringIndex = 6) + '-');
            if (newValue.selection.end >= 6) selectionIndex++;
          }
          if (newTextLength >= 11) {
            newText.write(
                newValue.text.substring(6, usedSubstringIndex = 10) + ' ');
            if (newValue.selection.end >= 10) selectionIndex++;
          }
          break;
        }
      case 91:
        {
          if (newTextLength >= 5) {
            newText.write(
                newValue.text.substring(0, usedSubstringIndex = 5) + ' ');
            if (newValue.selection.end >= 6) selectionIndex++;
          }
          break;
        }
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
