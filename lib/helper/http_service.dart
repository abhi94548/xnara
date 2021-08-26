import 'package:dio/dio.dart';

class HttpService {
  Dio dio = Dio();

  Future<Response<dynamic>> requestSource(String url, String method,
      {Map<String, dynamic>? data}) async {
    return dio.request(url,
        data: data,
        options: Options(
          method: method,
        ));
  }
}
