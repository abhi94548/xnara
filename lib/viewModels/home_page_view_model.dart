import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:xnara/helper/error_handler.dart';
import '../services/home_service.dart';

enum HomeNotifierState { loading, loaded }

class HomePageViewModel extends ChangeNotifier {
  final WebServiceFoodApi webServiceFoodApi = WebServiceFoodApi();

  HomeNotifierState _state = HomeNotifierState.loading;

  HomeNotifierState get state => _state;

  void _setState(HomeNotifierState state) {
    _state = state;
    notifyListeners();
  }

  late Either<ShowError, Map<String,dynamic>> _foodList;

  Either<ShowError, Map<String,dynamic>> get foodList => _foodList;

  void _setFoodList(Either<ShowError, Map<String,dynamic>> foodList) {
    _foodList = foodList;
    notifyListeners();
  }

  fetchFoods() async {
    await Task(() => webServiceFoodApi.fetchFoodList())
        .attempt()
        .map((Either<Object, Map<String,dynamic>> errorMap) =>
            errorMap.leftMap((Object errorObject) {
              try {
                return errorObject as ShowError;
              } catch (e) {
                throw errorObject;
              }
            }))
        .run()
        .then((Either<ShowError, Map<String,dynamic>> value) => _setFoodList(value));
    _setState(HomeNotifierState.loaded);
  }
}
