import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../../config.dart';
import '../../viewModels/image_upload_view_model.dart';
import '../Widgets/list_widget.dart';

class ImageUploadBodyWidget extends StatelessWidget {
  const ImageUploadBodyWidget(
      {required this.context,
      required this.model,
      required this.foodList,
      required this.imagePath});

  final BuildContext context;
  final Map<String, dynamic> model;
  final Map<String, dynamic> foodList;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    final List<String> keyList = model.keys.toList();
    final List<String> _foodList = foodList.keys.toList();

    showToast(String message) {
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: AppConfig().primaryColor,
          textColor: Colors.white,
          fontSize: 16.0);
    }

    Future<void> _displayTextInputDialog(
        BuildContext context, List<String> foods) async {
      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Enter new category'),
              content: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Column(
                  children: [
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        if (textEditingValue.text == '') {
                          return const Iterable<String>.empty();
                        }
                        return foods.where((String option) {
                          return option.contains(textEditingValue.text);
                        });
                      },
                      onSelected: (String selection) {
                        context
                            .read<ImageUploadViewModel>()
                            .setCategory(selection);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (context
                                    .read<ImageUploadViewModel>()
                                    .category
                                    .toString() !=
                                '') {
                              context
                                  .read<ImageUploadViewModel>()
                                  .addCategoryImage(
                                      imagePath,
                                      context
                                          .read<ImageUploadViewModel>()
                                          .category
                                          .toString());
                              showToast('Image Successfully Added');
                              Navigator.of(context)..pop()..pop();
                            } else {
                              showToast('Enter a valid Input');
                            }
                          },
                          child: const Text('Submit and Add')),
                    )
                  ],
                ),
              ),
            );
          });
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: model.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    context.read<ImageUploadViewModel>().addCategoryImage(
                        imagePath,
                        model[keyList[index]].toString());
                    showToast('Image Successfully Added');
                    Navigator.of(context).pop();
                  },
                  child: ListWidget(
                      foodName: keyList[index].toString(),
                      images:
                          model[keyList[index]].toString()));
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(2.0),
          child: Text(
            'Not in the Above Prediction? Add Now',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButton<String>(
            hint: const Text('Select existing Category'),
            onChanged: (String? newValue) {
              context.read<ImageUploadViewModel>().setCategory(newValue!);
            },
            items: _foodList.map<DropdownMenuItem<String>>((String e) {
              return DropdownMenuItem<String>(
                value: e,
                child: Text(e),
              );
            }).toList(),
            value:
                context.read<ImageUploadViewModel>().category.toString() == ''
                    ? _foodList[0]
                    : context.read<ImageUploadViewModel>().category,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (context.read<ImageUploadViewModel>().category.isNotEmpty) {
              context.read<ImageUploadViewModel>().addCategoryImage(
                  imagePath, context.read<ImageUploadViewModel>().category);
              showToast('Image Successfully Added');
              Navigator.of(context).pop();
            } else {
              showToast('Enter a valid Input');
            }
          },
          child: const Text('Add Image'),
        ),
        ElevatedButton(
          onPressed: () {
            _displayTextInputDialog(context, _foodList);
          },
          child: const Text('Add Custom Category'),
        )
      ],
    );
  }
}
