import 'dart:math';

import 'package:flutter/material.dart';

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
