import 'package:flutter/cupertino.dart';
import '../services/homePageService.dart';
import '../services/ImageUploadService.dart';

class ImageUploadViewModel extends ChangeNotifier {
  //late FoodModel foods;
  late Map<String, dynamic> responseList = {};
  late bool successUpload = false;
  String category = "";

  Future<Map<String, dynamic>?> fetchPredictions(String imagePath) async {
    var _foodList = await WebServiceFoodApi().fetchFoodList();
    var _list = await WebServiceImageUpload().imageUpload(imagePath);
    if (_foodList!.isEmpty || _list.isEmpty) {
      notifyListeners();
      return null;
    } else {
      responseList.putIfAbsent("predictionList", () => _list);
      responseList.putIfAbsent("foodList", () => _foodList);
      notifyListeners();
      return responseList;
    }
  }

  addCategoryImage(String imagePath, String category) async {
    var _list =
        await WebServiceImageUpload().categoryImage(imagePath, category);
    successUpload = _list;
    notifyListeners();
  }

  setCategory(String category) async {
    this.category = category;
    notifyListeners();
  }
}
