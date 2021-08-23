import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:autocomplete_textfield_ns/autocomplete_textfield_ns.dart';
import 'package:xnara/config.dart';
import '../../viewModels/ImageUploadViewModel.dart';
import '../../views/Widgets/ListWidget.dart';

class ImageUploadBodyWidget extends StatefulWidget {
  ImageUploadBodyWidget(
      {required this.context, required this.model, required this.imagePath});

  final BuildContext context;
  final Map<String, dynamic> model;
  final String imagePath;

  @override
  _ImageUploadBodyWidgetState createState() => _ImageUploadBodyWidgetState();
}

class _ImageUploadBodyWidgetState extends State<ImageUploadBodyWidget> {
  String category = "";
  final myController = TextEditingController();
  late SimpleAutoCompleteTextField textField;
  GlobalKey<AutoCompleteTextFieldState<String>> key = new GlobalKey();

  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: AppConfig().primaryColor,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Future<void> _displayTextInputDialog(
      BuildContext context, List<String> foods) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Enter new category'),
            content: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
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
                      print("Selected value is " + selection);
                      widget.context
                          .read<ImageUploadViewModel>()
                          .setCategory(selection);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          if (widget.context
                                  .read<ImageUploadViewModel>()
                                  .category
                                  .toString() !=
                              "") {
                            widget.context
                                .read<ImageUploadViewModel>()
                                .addCategoryImage(
                                    widget.imagePath,
                                    widget.context
                                        .read<ImageUploadViewModel>()
                                        .category
                                        .toString());
                            showToast("Image Successfully Added");
                            Navigator.of(context)..pop()..pop();
                          } else {
                            showToast("Enter a valid Input");
                          }
                        },
                        child: Text('Submit and Add')),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var keyList = widget.model['predictionList'].keys.toList();
    List<String> _foodList = widget.model['foodList'].keys.toList();
    print("foodList" + _foodList.length.toString());
    category = _foodList[0];
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.model['predictionList'].length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    widget.context
                        .read<ImageUploadViewModel>()
                        .addCategoryImage(
                            widget.imagePath,
                            widget.model['predictionList'][keyList[index]]
                                .toString());
                    showToast("Image Successfully Added");
                    Navigator.of(context).pop();
                  },
                  child: ListWidget(
                      foodName: keyList[index].toString(),
                      images: widget.model['predictionList'][keyList[index]]
                          .toString()));
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Text(
            'Not in the Above Prediction? Add Now',
            style: TextStyle(fontSize: 15),
          ),
        ),
        Consumer<ImageUploadViewModel>(
          builder: (contextBuild, model, _) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: new DropdownButton<String>(
                hint: Text('Select existing Category'),
                onChanged: (newValue) {
                  print("Old value" +
                      widget.context.read<ImageUploadViewModel>().category);
                  print(newValue);
                  widget.context
                      .read<ImageUploadViewModel>()
                      .setCategory(newValue!);
                },
                items: _foodList.map<DropdownMenuItem<String>>((String e) {
                  return new DropdownMenuItem<String>(
                    child: Text(e),
                    value: e,
                  );
                }).toList(),
                value: widget.context
                            .read<ImageUploadViewModel>()
                            .category
                            .toString() ==
                        ""
                    ? category
                    : widget.context.read<ImageUploadViewModel>().category,
              ),
            );
          },
        ),
        ElevatedButton(
          onPressed: () {
            if (category.isNotEmpty) {
              widget.context
                  .read<ImageUploadViewModel>()
                  .addCategoryImage(widget.imagePath, category);
              showToast("Image Successfully Added");
              Navigator.of(context).pop();
            } else {
              showToast("Enter a valid Input");
            }
          },
          child: Text('Add Image'),
        ),
        ElevatedButton(
          onPressed: () {
            _displayTextInputDialog(context, _foodList);
          },
          child: Text('Add Custom Category'),
        )
      ],
    );
  }
}
