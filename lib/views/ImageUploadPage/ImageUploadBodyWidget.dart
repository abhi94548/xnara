import 'package:flutter/material.dart';
import '../../views/Widgets/ListWidget.dart';

class ImageUploadBodyWidget extends StatefulWidget {
  ImageUploadBodyWidget({required this.context, required this.model});

  final BuildContext context;

  //final FoodModel model;
  final Map<String, dynamic> model;

  @override
  _ImageUploadBodyWidgetState createState() => _ImageUploadBodyWidgetState();
}

class _ImageUploadBodyWidgetState extends State<ImageUploadBodyWidget> {
  @override
  Widget build(BuildContext context) {
    var keyList = widget.model.keys.toList();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.model.length,
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    print("Pressed value " + widget.model[keyList[index]].toString());
                  },
                  child: ListWidget(
                      foodName: keyList[index].toString(),
                      images: widget.model[keyList[index]].toString()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text('Not in the Above Prediction? Add Now',
            style: TextStyle(
                fontSize: 15
            ),
          ),
        ),
      ],
    );
  }
}
