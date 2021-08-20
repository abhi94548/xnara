import 'package:flutter/material.dart';

class HomePageListWidget extends StatelessWidget {
   HomePageListWidget({required this.foodName,required this.images});

   final String foodName;
   final int images;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        elevation: 2.0,
        child: ListTile(
          title: Text(foodName),
          subtitle: Text(images.toString()),
        ),
      ),
    ) ;
  }
}
