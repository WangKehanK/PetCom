import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:petcom/constants.dart';

String smallSentence(String bigSentence) {
  final int len = 16;
  if (bigSentence.length > len) {
    return bigSentence.substring(0, len) + '..';
  } else {
    return bigSentence;
  }
}

String mediumSentence(String bigSentence) {
  final int len = 200;
  if (bigSentence.length > len) {
    return bigSentence.substring(0, len) + '..';
  } else {
    return bigSentence;
  }
}

Color? randomColor() {
  final colors = [
    Colors.blueGrey[200],
    Colors.green[200],
    Colors.pink[100],
    Colors.brown[200],
    Colors.lightBlue[200],
  ];

  Random _random = new Random();
  final randomColor = colors[_random.nextInt(colors.length)];
  return randomColor;
}

String getType(String type) {
  String result = '';
  if (type == '0') {
    result = "Kitten Breeder";
  } else if (type == '1') {
    result = "Shelter";
  } else if (type == '2') {
    result = "Puppy Breeder";
  }
  return result;
}

String? randomPath() {
  String ranPath = "assets/images/dog1.png";
  Random _random = new Random();
  ranPath = imagePaths[_random.nextInt(imagePaths.length)];
  return ranPath;
}

String? randomDogPath() {
  String ranPath = "assets/images/dog-1.png";
  Random _random = new Random();
  ranPath = dogPaths[_random.nextInt(dogPaths.length)];
  return ranPath;
}

String? randomCatPath() {
  String ranPath = "assets/images/cat-1.png";
  Random _random = new Random();
  ranPath = catPaths[_random.nextInt(catPaths.length)];
  return ranPath;
}

String? randomShelterPath() {
  String ranPath = "assets/images/cat-1.png";
  Random _random = new Random();
  ranPath = shelterPaths[_random.nextInt(shelterPaths.length)];
  return ranPath;
}

String? getDesiredImagePath(String? type) {
  String res = "";
  if (type == '0') {
    res = randomCatPath()!;
  } else if (type == '1') {
    res = randomShelterPath()!;
  } else {
    res = randomDogPath()!;
  }
  return res;
}

DateTime convertDate(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = now.difference(date);
  var time = '';
  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' DAY AGO';
    } else {
      time = diff.inDays.toString() + ' DAYS AGO';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
    } else {
      time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
    }
  }
  return time;
}
