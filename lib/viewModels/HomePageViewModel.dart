import 'package:flutter/cupertino.dart';
import '/models/FoodApi/food_Model.dart';
import '/services/homePageService.dart';


class HomePageViewModel extends ChangeNotifier{

    //late FoodModel foods;
    late Map<String,dynamic> foods = {};
    bool loading = false;

    fetchFoods() async {
        loading = true;
        //FoodModel _list = await WebServiceFoodApi().fetchFoodList();
        var _list = await WebServiceFoodApi().fetchFoodList();
        print(_list.toString());
        this.foods = _list;
        loading = false;
        notifyListeners();
    }
}