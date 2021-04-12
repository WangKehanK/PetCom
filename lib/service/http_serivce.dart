import 'package:dio/dio.dart';

class HttpService {
  late Dio _dio;

  // final String baseUrl = "http://10.0.2.2:8080/community";
  final String baseUrl =
      "http://ec2-3-16-186-105.us-east-2.compute.amazonaws.com:8080/community";

  HttpService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
    ));

    initializaInterceptors();
  }

  Future<Response> getRequest(String endPoint) async {
    Response response;
    try {
      response = await _dio.get(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  Future<Response> postRequest(String endPoint) async {
    Response response;
    try {
      response = await _dio.post(endPoint);
    } on DioError catch (e) {
      print(e.message);
      throw Exception(e.message);
    }

    return response;
  }

  initializaInterceptors() {
    //https://pub.dev/documentation/dio/latest/dio/InterceptorsWrapper-class.html
    _dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      handler.next(error);
    }, onRequest: (request, handler) {
      handler.next(request);
    }, onResponse: (Response response, handler) {
      handler.next(response);
    }));
  }
}
