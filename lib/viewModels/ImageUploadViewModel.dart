import 'package:flutter/cupertino.dart';
import '/services/ImageUploadService.dart';
import '/models/FoodApi/food_Model.dart';


class ImageUploadViewModel extends ChangeNotifier{

  late FoodModel foods;
  bool loading = false;

  Future<FoodModel> fetchPredictions(String imagePath) async {
    loading = true;
    FoodModel _list = await WebServiceImageUpload().imageUpload(imagePath);
    this.foods = _list;
    loading = false;
    notifyListeners();
    return foods;
  }
}