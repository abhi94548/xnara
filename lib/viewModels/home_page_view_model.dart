import 'package:flutter/cupertino.dart';
import 'package:xnara/helper/error_handler.dart';
import '../services/home_service.dart';

enum HomeNotifierState { loading, loaded, error }

class HomePageViewModel extends ChangeNotifier {
  final WebServiceFoodApi webServiceFoodApi = WebServiceFoodApi();

  HomeNotifierState _state = HomeNotifierState.loading;

  HomeNotifierState get state => _state;

  void _setState(HomeNotifierState state) {
    _state = state;
    notifyListeners();
  }

  late Map<String, dynamic> _foodList;

  Map<String, dynamic> get foodList => _foodList;

  void _setFoodList(Map<String, dynamic> foodList) {
    _foodList = foodList;
    notifyListeners();
  }

  late ShowError _error;

  ShowError get error => _error;

  void _setError(ShowError error) {
    _error = error;
    notifyListeners();
  }

  fetchFoods() async {
    try {
      _setFoodList(await webServiceFoodApi.fetchFoodList());
      _setState(HomeNotifierState.loaded);
      notifyListeners();
    } on ShowError catch (error) {
      _setState(HomeNotifierState.error);
      _setError(error);
    }
  }
}
