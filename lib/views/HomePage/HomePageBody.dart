import 'package:flutter/material.dart';
import '../../views/Widgets/ListWidget.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({required this.context, required this.model});

  final BuildContext context;
  final Map<String, dynamic> model;

  @override
  Widget build(BuildContext context) {
    final List<String> keyList = model.keys.toList();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListView.builder(
        itemCount: model.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return ListWidget(
              foodName: keyList[index].toString(),
              images: model[keyList[index]].toString());
        },
      ),
    );
  }
}
