import 'package:flutter/cupertino.dart';

import '../helper/error_handler.dart';
import '../services/home_service.dart';
import '../services/image_upload_service.dart';

enum ImageUploadNotifierState { loading, loaded, error }

class ImageUploadViewModel extends ChangeNotifier {
  WebServiceImageUpload webServiceImageUpload = WebServiceImageUpload();
  final WebServiceFoodApi webServiceFoodApi = WebServiceFoodApi();

  late bool successUpload = false;
  String category = '';

  ImageUploadNotifierState _state = ImageUploadNotifierState.loading;

  ImageUploadNotifierState get state => _state;

  void _setState(ImageUploadNotifierState state) {
    _state = state;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  late Map<String, dynamic> _responseList;

  Map<String, dynamic> get responseList => _responseList;

  void _setResponseList(Map<String, dynamic> responseList) {
    _responseList = responseList;
    notifyListeners();
  }

  late Map<String, dynamic> _foodList;

  Map<String, dynamic> get foodList => _foodList;

  void _setFoodList(Map<String, dynamic> foodList) {
    _foodList = foodList;
    notifyListeners();
  }

  fetchPredictions(String imagePath) async {
    try {
      _setResponseList(await webServiceImageUpload.imageUpload(imagePath));
      _setFoodList(await webServiceFoodApi.fetchFoodList());
      _setState(ImageUploadNotifierState.loaded);
      notifyListeners();
    } on ShowError catch (error) {
      _setState(ImageUploadNotifierState.error);
      _setError(error);
    }
  }

  addCategoryImage(String imagePath, String category) async {
    try {
      final bool _list = await webServiceImageUpload.addCustomCategoryImage(
          imagePath, category);
      successUpload = _list;
      _setState(ImageUploadNotifierState.loaded);
      notifyListeners();
    } on ShowError catch (error) {
      _setState(ImageUploadNotifierState.error);
      _setError(error);
    }
  }

  setCategory(String category) async {
    this.category = category;
    notifyListeners();
  }
}
