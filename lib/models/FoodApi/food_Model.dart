import 'dart:convert';

FoodModel foodModelFromJson(String str) => FoodModel.fromJson(json.decode(str) as Map<String,dynamic>);

String foodModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel {
  FoodModel({
    required this.status,
    required this.foodList,
  });

  bool status;
  List<FoodList> foodList;

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
    status: json["status"] as bool,
    foodList: List<FoodList>.from(json["foodList"].map((x) => FoodList.fromJson(x as Map<String,dynamic>) ) as Iterable<dynamic>),
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
    foodName: json["foodName"] as String,
    images: json["images"] as int,
  );

  Map<String, dynamic> toJson() => {
    "foodName": foodName,
    "images": images,
  };
}
