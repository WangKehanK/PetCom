import 'package:dio/dio.dart';
import 'package:petcom/components/constants.dart'; //baseUrl

getPost() async {
  try {
    // TODO: How to parse the data?
    var response = await Dio().get("$baseUrl/community/index");
    print(response.data);
  } catch (e) {
    print(e);
  }
}
