import 'package:flutter/cupertino.dart';
import '../services/homePageService.dart';

class HomePageViewModel extends ChangeNotifier {
  //late FoodModel foods;
  late Map<String, dynamic> foods = {};

  Future<Map<String, dynamic>?> fetchFoods() async {
    //FoodModel _list = await WebServiceFoodApi().fetchFoodList();
    try {
      var _list = await WebServiceFoodApi().fetchFoodList();
      print(_list.toString());
      this.foods = _list!;
      notifyListeners();
      return foods;
    } catch (e) {
      return null;
    }
  }
}
