import 'package:dio/dio.dart';

class HttpService {
  late Dio _dio;

  final String baseUrl = "http://10.0.2.2:8080/community";

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
    _dio.interceptors.add(InterceptorsWrapper(onError: (error) {
      print(error.message);
    }, onRequest: (request) {
      print("${request.method} ${request.path}");
    }, onResponse: (response) {
      print(response.data);
    }));
  }
}
