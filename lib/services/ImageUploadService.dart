import 'dart:math';

import 'package:dio/dio.dart';
import '../config.dart';

class WebServiceImageUpload {


  Dio dio = Dio();
  static const String _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  final Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));



  Future<Map<String, dynamic>> imageUpload(String imagePath) async {
    final FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath,
          filename: getRandomString(15)),
    });

    final Response<dynamic> response = await dio.post(
      AppConfig().foodApiInference,
      data: formData,
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode == 200) {
      return response.data as Map<String,dynamic>;
    } else {
      throw Exception('Unable to Connect');
    }
  }


  Future<bool> categoryImage(String imagePath, String category) async {

    final FormData formData = FormData.fromMap({
      'category': category,
      'image': await MultipartFile.fromFile(imagePath,
          filename: getRandomString(15)),
    });

    final Response<dynamic> response = await dio.post(
      AppConfig().foodApiAdd,
      data: formData,
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }


}
