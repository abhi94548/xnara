import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../views/Widgets/LoadingTextWidget.dart';

import '../../config.dart';
import '../../viewModels/ImageUploadViewModel.dart';
import '../ImageUploadPage/ImageUploadBodyWidget.dart';

class ImageUploadPageWidget extends StatefulWidget {
  const ImageUploadPageWidget({Key? key}) : super(key: key);

  @override
  _ImageUploadPageWidgetState createState() => _ImageUploadPageWidgetState();
}

class _ImageUploadPageWidgetState extends State<ImageUploadPageWidget> {
  final picker = ImagePicker();
  late String imagePath = "";

  bool permissionStatus = false;

  _requestPermission() async {
    var cameraPermission = await Permission.camera.status;
    var storagePermission = await Permission.storage.status;
    if (cameraPermission.isGranted && storagePermission.isGranted) {
      permissionStatus = true;
      setState(() {});
    }
    print("permission granted" + permissionStatus.toString());
  }

  Future getImage() async {
    final pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 500.0,
        maxHeight: 500.0,
        imageQuality: 80);

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
    if (croppedImage != null) {
      print(croppedImage.path.toString());
      setState(() {
        imagePath = croppedImage.path.toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    var _predictionList =
        Provider.of<ImageUploadViewModel>(context, listen: false)
            .fetchPredictions(imagePath);
    return ChangeNotifierProvider(
      create: (_) => ImageUploadViewModel(),
      child: Scaffold(
        appBar: PreferredSize(
          child: AppBar(
            backgroundColor: AppConfig().primaryColor,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: Icon(Icons.arrow_back),
            ),
            title: Text('Predictions'),
          ),
          preferredSize: Size.fromHeight(50),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: SafeArea(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FutureBuilder(
                    future: _predictionList,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          LoadingTextWidget(
                              loadingText:
                              "Something went wrong. Internet or server error");
                        } else {
                          return ImageUploadBodyWidget(
                            context: context,
                            model: snapshot.data,
                            imagePath: imagePath,
                          );
                        }
                      }
                      if (snapshot.connectionState == ConnectionState.waiting ||
                          snapshot.connectionState == ConnectionState.active) {
                        return LoadingTextWidget(
                            loadingText: "Loading Please Wait..");
                      } else {
                        return LoadingTextWidget(
                            loadingText: "Loading Please Wait..");
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
