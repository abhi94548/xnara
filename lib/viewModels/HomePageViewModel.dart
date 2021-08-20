import 'package:flutter/cupertino.dart';
import '/models/FoodApi/food_Model.dart';
import '/services/homePageService.dart';


class HomePageViewModel extends ChangeNotifier{

    late FoodModel foods;
    bool loading = false;

    Future<FoodModel> fetchFoods() async {
        loading = true;
        FoodModel _list = await WebServiceFoodApi().fetchFoodList();
        this.foods = _list;
        loading = false;
        notifyListeners();
        return foods;
    }
}