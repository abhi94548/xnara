import 'package:flutter/material.dart';

class HomePageListWidget extends StatelessWidget {
   const HomePageListWidget({required this.foodName,required this.images});

   final String foodName;
   final String images;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: ListTile(
        title: Text(foodName),
        subtitle: Text(images),
      ),
    ) ;
  }
}
