import 'package:dio/dio.dart';

import '../config.dart';
import '../helper/error_handler.dart';
import '../helper/http_service.dart';

class WebServiceFoodApi {
  final HttpService httpService = HttpService();

  Future<Map<String, dynamic>> fetchFoodList() async {
    try {
      final Response<dynamic> response =
          await httpService.requestSource(AppConfig().foodApiList, 'GET');
      return response.data as Map<String, dynamic>;
    } on DioError catch (error) {
      if (error.type == DioErrorType.receiveTimeout ||
          error.type == DioErrorType.connectTimeout) {
        throw ShowError('Server timeout ');
      } else if (error.type == DioErrorType.other) {
        throw ShowError('No Internet connection...');
      } else {
        throw ShowError('Something went wrong');
      }
    }
  }
}
