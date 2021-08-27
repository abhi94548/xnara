import 'dart:math';

import 'package:dio/dio.dart';

import '../config.dart';
import '../helper/error_handler.dart';
import '../helper/http_service.dart';

class WebServiceImageUpload {
  final HttpService httpService = HttpService();
  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

  Future<Map<String, dynamic>> imageUpload(String imagePath) async {
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'image': await MultipartFile.fromFile(imagePath,
          filename: getRandomString(15)),
    });
    try {
      final Response<dynamic> response = await httpService.requestSource(
          AppConfig().foodApiInference, 'POST',
          formData: formData);
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

  Future<bool> addCustomCategoryImage(String imagePath, String category) async {
    final FormData formData = FormData.fromMap(<String, dynamic>{
      'category': category,
      'image': await MultipartFile.fromFile(imagePath,
          filename: getRandomString(15)),
    });
    try {
      final Response<dynamic> response = await httpService
          .requestSource(AppConfig().foodApiAdd, 'POST', formData: formData);
      return true;
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
