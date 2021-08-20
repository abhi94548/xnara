import 'package:flutter/material.dart';
import '../HomePage/Widgets/HomePageListWidget.dart';
import '/models/FoodApi/food_Model.dart';

class HomePageBody extends StatefulWidget {
  HomePageBody({required this.context, required this.model});

  final BuildContext context;
  final FoodModel model;

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: widget.model.foodList.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            return HomePageListWidget(foodName: widget.model.foodList[index].foodName , images: widget.model.foodList[index].images);
          },
        ),
      ),
    );
  }
}
