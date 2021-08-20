import 'dart:convert';

import 'package:dio/dio.dart';
import '../config.dart';
import '../models/FoodApi/food_Model.dart';


class WebServiceFoodApi {
  var dio = new Dio();

  Future<FoodModel> fetchFoodList() async {

    final response = await dio.get(AppConfig().foodApiList);

    if(response.statusCode == 200){
      print('called' + response.data.toString());
      final FoodModel _lists = foodModelFromJson(jsonEncode(response.data));
      return _lists;
    } else {
      throw Exception('Unable to Connect');
    }
  }
}