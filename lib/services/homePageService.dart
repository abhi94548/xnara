import 'package:dio/dio.dart';
import '../config.dart';
import '../models/FoodApi/food_Model.dart';


class WebServiceFoodApi {
  var dio = new Dio();

  Future<List<FoodModel>> fetchArticle() async {

    final response = await dio.get(AppConfig().foodApiList);

    if(response.statusCode == 200){
      final result = response.data;
      Iterable list = result['Foods'];
      return list.map((food) => FoodModel.fromJson(food)).toList();
    } else {
      throw Exception('Unable to Connect');
    }
  }
}