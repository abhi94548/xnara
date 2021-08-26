import 'package:flutter/material.dart';
import '../Widgets/list_widget.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({required this.context, required this.foodModel});

  final BuildContext context;
  final Map<String,dynamic> foodModel;

  @override
  Widget build(BuildContext context) {
    final List<String> keyList = foodModel.keys.toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: foodModel.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListWidget(
              foodName: keyList[index].toString(),
              images: foodModel[keyList[index]].toString());
        },
      ),
    );
  }
}
