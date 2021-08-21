import 'package:flutter/cupertino.dart';
import '/services/ImageUploadService.dart';
import '/models/FoodApi/food_Model.dart';


class ImageUploadViewModel extends ChangeNotifier{

  //late FoodModel foods;
  late Map<String,dynamic> foods = {};
  bool loading = false;

  fetchPredictions(String imagePath) async {
    loading = true;
    //FoodModel _list = await WebServiceImageUpload().imageUpload(imagePath);
    var _list = await WebServiceImageUpload().imageUpload(imagePath);
    this.foods = _list;
    loading = false;
    notifyListeners();
  }
}