import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '/views/Widgets/HeadTextWidget.dart';
import '../../viewModels/ImageUploadViewModel.dart';


class ImageUploadPageWidget extends StatefulWidget {
  const ImageUploadPageWidget({Key? key}) : super(key: key);

  @override
  _ImageUploadPageWidgetState createState() => _ImageUploadPageWidgetState();
}

class _ImageUploadPageWidgetState extends State<ImageUploadPageWidget> {

  final picker = ImagePicker();
  late String imagePath = "";

  Future getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 500.0,
        maxHeight: 500.0,
        imageQuality: 80
    );

    setState(() {
      if (pickedFile != null) {
        _cropImage(pickedFile.path, '');
      } else {
        print('No image selected.');
      }
    });
  }

  _cropImage(filePath, String category) async {
    File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
    );
    if(croppedImage != null){
      print(croppedImage.path.toString());
      setState(() {
        imagePath = croppedImage.path.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ImageUploadViewModel(),
      child: Scaffold(
        body: Consumer<ImageUploadViewModel>(
          builder: (context, model, _) {
            context.read<ImageUploadViewModel>().fetchPredictions(imagePath);
            print(context.read<ImageUploadViewModel>().loading.toString());
            return SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadTextWidget(headText: 'Predictions'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
