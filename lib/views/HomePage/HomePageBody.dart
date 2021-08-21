import 'package:flutter/material.dart';
import '../../views/Widgets/ListWidget.dart';


class HomePageBody extends StatefulWidget {
  HomePageBody({required this.context, required this.model});

  final BuildContext context;
  //final FoodModel model;
  final Map<String,dynamic> model;

  @override
  _HomePageBodyState createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    var keyList = widget.model.keys.toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.model.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListWidget(foodName: keyList[index].toString() , images: widget.model[keyList[index]].toString());
        },
      ),
    );
  }
}
