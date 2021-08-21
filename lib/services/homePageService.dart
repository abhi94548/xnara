import 'dart:convert';

import 'package:dio/dio.dart';
import '../config.dart';

class WebServiceFoodApi {
  var dio = new Dio();

  Future<Map<String, dynamic>> fetchFoodList() async {


    final response = await dio.get(
      AppConfig().foodApiList,
      options: Options(
        responseType: ResponseType.json,
      ),
    );

    if (response.statusCode == 200) {
      var reply = response.data;
      //final FoodModel _lists = foodModelFromJson(jsonEncode(response.data));
      var _lists = reply;
      return _lists;
    } else {
      throw Exception('Unable to Connect');
    }
  }
}
