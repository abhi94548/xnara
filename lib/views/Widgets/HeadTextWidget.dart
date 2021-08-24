import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/viewModels/ChatUI/ChatUIViewModel.dart';
import 'package:xnara/viewModels/ImageUploadViewModel.dart';

import '../../config.dart';
import '../../views/ChatPage/ChatUI/ChatUIPageWidget.dart';
import '../../views/ImageUploadPage/ImageUploadPageWidget.dart';

class HeadTextWidget extends StatelessWidget {
  const HeadTextWidget({required this.headText, required this.routeName});

  final String headText;
  final String routeName;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            headText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          if (routeName == 'chatPage' || routeName == 'homePage') FloatingActionButton(
                  elevation: 0.0,
                  mini: true,
                  backgroundColor: AppConfig().primaryColor,
                  onPressed: () {
                    if (routeName == 'chatPage') {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MultiProvider(providers: [
                          ChangeNotifierProvider(
                              create: (_) => ChatUIViewModel())
                        ], child: ChatUIPageWidget()),
                      ));
                    } else {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => MultiProvider(providers: [
                          ChangeNotifierProvider(
                              create: (_) => ImageUploadViewModel())
                        ], child: const ImageUploadPageWidget()),
                      ));
                    }
                  },
                  child: routeName == 'chatPage'
                      ?  const Icon(Icons.chat)
                      : const Icon(Icons.camera)) else const SizedBox()
        ],
      ),
    );
  }
}
