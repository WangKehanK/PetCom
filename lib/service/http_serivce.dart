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
    //https://pub.dev/documentation/dio/latest/dio/InterceptorsWrapper-class.html
    _dio.interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      print("error" + error.message);
      handler.next(error);
    }, onRequest: (request, handler) {
      print("${request.method} ${request.path}");
      handler.next(request);
    }, onResponse: (Response response, handler) {
      print(response.data);
      handler.next(response);
    }));
  }
}
