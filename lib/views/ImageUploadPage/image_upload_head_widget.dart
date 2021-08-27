import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../viewModels/image_upload_view_model.dart';
import '../Widgets/loading_text_widget.dart';
import 'Widget/image_upload_app_bar_widget.dart';
import 'image_upload_body_widget.dart';

class ImageUploadPageWidget extends StatefulWidget {
  const ImageUploadPageWidget();

  @override
  _ImageUploadPageWidgetState createState() => _ImageUploadPageWidgetState();
}

class _ImageUploadPageWidgetState extends State<ImageUploadPageWidget> {
  final ImagePicker picker = ImagePicker();
  late String imagePath = '';

  bool permissionStatus = false;

  _requestPermission() async {
    final PermissionStatus cameraPermission = await Permission.camera.status;
    final PermissionStatus storagePermission = await Permission.storage.status;
    if (cameraPermission.isGranted && storagePermission.isGranted) {
      permissionStatus = true;
      setState(() {});
    }
  }

  getImage() async {
    final XFile? pickedFile = await picker.pickImage(
        source: ImageSource.camera,
        maxWidth: 500.0,
        maxHeight: 500.0,
        imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        _cropImage(pickedFile.path, '');
      }
    });
  }

  _cropImage(String filePath, String category) async {
    final File? croppedImage = await ImageCropper.cropImage(
      sourcePath: filePath,
    );
    if (croppedImage != null) {
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
    Provider.of<ImageUploadViewModel>(context, listen: true)
        .fetchPredictions(imagePath);
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: ImageUploadAppBarWidget(),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Consumer<ImageUploadViewModel>(
                builder: (BuildContext context, ImageUploadViewModel model, _) {
                  if (model.state == ImageUploadNotifierState.loading) {
                    return const LoadingTextWidget(
                        loadingText: 'Loading Please Wait');
                  } else if (model.state == ImageUploadNotifierState.error) {
                    return const LoadingTextWidget(
                        loadingText: 'Something went wrong');
                  } else {
                    return ImageUploadBodyWidget(
                        context: context,
                        model: model.responseList,
                        foodList: model.foodList,
                        imagePath: imagePath);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
