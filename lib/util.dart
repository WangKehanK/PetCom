String smallSentence(String bigSentence) {
  final int len = 16;
  if (bigSentence.length > len) {
    return bigSentence.substring(0, len) + '..';
  } else {
    return bigSentence;
  }
}
