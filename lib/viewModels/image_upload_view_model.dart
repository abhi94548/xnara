import 'package:flutter/cupertino.dart';

import '../services/home_service.dart';
import '../services/image_upload_service.dart';

class ImageUploadViewModel extends ChangeNotifier {
  late Map<String, dynamic> responseList = {};
  late bool successUpload = false;
  String category = '';

  Future<Map<String, dynamic>?> fetchPredictions(String imagePath) async {
    final Map<String, dynamic> _foodList = await WebServiceFoodApi().fetchFoodList();
    final Map<String, dynamic> _list = await WebServiceImageUpload().imageUpload(imagePath);
      responseList.putIfAbsent('predictionList', () => _list);
      responseList.putIfAbsent('foodList', () => _foodList);
      notifyListeners();
      return responseList;
  }

  addCategoryImage(String imagePath, String category) async {
    final bool _list =
        await WebServiceImageUpload().categoryImage(imagePath, category);
    successUpload = _list;
    notifyListeners();
  }

  setCategory(String category) async {
    this.category = category;
    notifyListeners();
  }
}
