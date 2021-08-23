import 'dart:math';

import 'package:dio/dio.dart';
import '../config.dart';

class WebServiceImageUpload {


  var dio = new Dio();
  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
      length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));



  Future<Map<String, dynamic>> imageUpload(String imagePath) async {
    Map<String, dynamic> foodList = {};
    var formData;
    print(imagePath + "new   ");
    formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(imagePath,
          filename: getRandomString(15)),
    });

    final response = await dio.post(
      AppConfig().foodApiInference,
      data: formData,
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode == 200) {
      print('called' + response.data.toString());
      var reply = response.data;
      //final FoodModel _lists = foodModelFromJson(jsonEncode(response.data));
      foodList = reply;
      return foodList;
    } else {
      throw Exception('Unable to Connect');
    }
  }


  Future<bool> categoryImage(String imagePath, String category) async {
    var formData;
    print(imagePath + "new   ");
    formData = FormData.fromMap({
      'category': category,
      'image': await MultipartFile.fromFile(imagePath,
          filename: getRandomString(15)),
    });

    final response = await dio.post(
      AppConfig().foodApiAdd,
      data: formData,
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode == 200) {
      print('called' + response.data.toString());
      return true;
    } else {
      return false;
    }
  }


}
