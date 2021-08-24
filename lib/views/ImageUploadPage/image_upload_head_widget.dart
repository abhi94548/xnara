import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import '../../config.dart';
import '../../viewModels/image_upload_view_model.dart';
import '../Widgets/loading_text_widget.dart';
import 'image_upload_body_widget.dart';

class ImageUploadPageWidget extends StatefulWidget {
  const ImageUploadPageWidget({Key? key}) : super(key: key);

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
    final _predictionList =
    Provider.of<ImageUploadViewModel>(context, listen: false)
        .fetchPredictions(imagePath);
    return ChangeNotifierProvider(
      create: (_) => ImageUploadViewModel(),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            backgroundColor: AppConfig().primaryColor,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back),
            ),
            title: const Text('Predictions'),
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FutureBuilder(
                  future: _predictionList,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null) {
                        const LoadingTextWidget(
                            loadingText:
                            'Something went wrong. Internet or server error');
                      } else {
                        return ImageUploadBodyWidget(
                          context: context,
                          model: snapshot.data as Map<String,dynamic>,
                          imagePath: imagePath,
                        );
                      }
                    }
                    if (snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.connectionState == ConnectionState.active) {
                      return const LoadingTextWidget(
                          loadingText: 'Loading Please Wait..');
                    } else {
                      return const LoadingTextWidget(
                          loadingText: 'Loading Please Wait..');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
