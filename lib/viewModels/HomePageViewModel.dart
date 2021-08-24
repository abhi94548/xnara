import 'package:flutter/cupertino.dart';
import '../services/homePageService.dart';

class HomePageViewModel extends ChangeNotifier {
  late Map<String, dynamic> foods = {} as Map<String,dynamic>;

  Future<Map<String, dynamic>> fetchFoods() async {
    try {
      final Map<String, dynamic> _list = await WebServiceFoodApi().fetchFoodList();
      foods = _list;
      notifyListeners();
      return foods;
    } catch (e) {
      throw Exception('Something went wrong');
    }
  }
}
