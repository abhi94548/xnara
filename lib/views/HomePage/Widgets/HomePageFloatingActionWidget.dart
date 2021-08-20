import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:xnara/views/ImageUploadPage/ImageUploadPageWidget.dart';

import '../../../config.dart';

class HomePageFloatingAction extends StatefulWidget {
  const HomePageFloatingAction({Key? key}) : super(key: key);

  @override
  _HomePageFloatingActionState createState() => _HomePageFloatingActionState();
}

class _HomePageFloatingActionState extends State<HomePageFloatingAction> {

  bool permissionStatus = false;



  _requestPermission() async {
    var cameraPermission =  await Permission.camera.status;
    var storagePermission = await Permission.storage.status;
    if(cameraPermission.isGranted && storagePermission.isGranted){
      permissionStatus = true;
      setState(() {});
    }
    print("permission granted");
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => ImageUploadPageWidget()));
}

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new FloatingActionButton(
        elevation: 0.0,
        child: new Icon(Icons.camera),
        backgroundColor: AppConfig().primaryColor,
        onPressed: () {
          _requestPermission();
        },
      ),
    );
  }
}
