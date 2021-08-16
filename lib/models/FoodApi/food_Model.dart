class FoodModel{
  final String foodName;

  FoodModel(
      {required this.foodName});

  factory FoodModel.fromJson(Map<String, dynamic> json) {

    return FoodModel(
        foodName: json['FoodName']);
  }
}