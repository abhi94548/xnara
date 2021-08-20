import 'dart:convert';

FoodModel foodModelFromJson(String str) => FoodModel.fromJson(json.decode(str));

String foodModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel {
  FoodModel({
    required this.status,
    required this.foodList,
  });

  bool status;
  List<FoodList> foodList;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
    status: json["status"],
    foodList: List<FoodList>.from(json["foodList"].map((x) => FoodList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "foodList": List<dynamic>.from(foodList.map((x) => x.toJson())),
  };
}

class FoodList {
  FoodList({
    required this.foodName,
    required this.images,
  });

  String foodName;
  int images;

  factory FoodList.fromJson(Map<String, dynamic> json) => FoodList(
    foodName: json["foodName"],
    images: json["images"],
  );

  Map<String, dynamic> toJson() => {
    "foodName": foodName,
    "images": images,
  };
}
