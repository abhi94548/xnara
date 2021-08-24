import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/viewModels/ChatUI/ChatUIViewModel.dart';
import 'package:xnara/viewModels/ImageUploadViewModel.dart';
import '../../views/ImageUploadPage/ImageUploadPageWidget.dart';
import '../../config.dart';
import '../../views/ChatPage/ChatUI/ChatUIPageWidget.dart';

class HeadTextWidget extends StatelessWidget {
  HeadTextWidget({required this.headText, required this.routeName});

  final String headText;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              headText,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
            ),
            routeName == "chatPage" || routeName == "homePage"
                ? FloatingActionButton(
                    elevation: 0.0,
                    child: routeName == "chatPage"
                        ? new Icon(Icons.chat)
                        : new Icon(Icons.camera),
                    mini: true,
                    backgroundColor: AppConfig().primaryColor,
                    onPressed: () {
                      if (routeName == "chatPage") {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiProvider(providers: [
                            ChangeNotifierProvider(
                                create: (_) => ChatUIViewModel())
                          ], child: ChatUIPageWidget()),
                        ));
                      } else {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MultiProvider(providers: [
                            ChangeNotifierProvider(
                                create: (_) => ImageUploadViewModel())
                          ], child: ImageUploadPageWidget()),
                        ));
                      }
                    })
                : Container()
          ],
        ),
      ),
    );
  }
}
