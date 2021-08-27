import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/viewModels/ChatUI/chat_ui_view_model.dart';
import 'package:xnara/viewModels/image_upload_view_model.dart';

import '../../config.dart';
import '../ChatPage/ChatUI/chat_ui_head_widget.dart';
import '../ImageUploadPage/image_upload_head_widget.dart';

class HeadTextWidget extends StatelessWidget {
  const HeadTextWidget(
      {required this.headText, required this.routeName, this.foodList});

  final String headText;
  final String routeName;
  final Map<String, dynamic>? foodList;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            headText,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
          ),
          if (routeName == 'chatPage' || routeName == 'homePage')
            FloatingActionButton(
                elevation: 0.0,
                mini: true,
                backgroundColor: AppConfig().primaryColor,
                onPressed: () {
                  if (routeName == 'chatPage') {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MultiProvider(
                          providers: <ChangeNotifierProvider<ChatUIViewModel>>[
                            ChangeNotifierProvider<ChatUIViewModel>(
                                create: (_) => ChatUIViewModel())
                          ],
                          child: ChatUIPageWidget()),
                    ));
                  } else {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => MultiProvider(
                          providers: <
                              ChangeNotifierProvider<ImageUploadViewModel>>[
                            ChangeNotifierProvider<ImageUploadViewModel>(
                                create: (_) => ImageUploadViewModel())
                          ],
                          child: const ImageUploadPageWidget()),
                    ));
                  }
                },
                child: routeName == 'chatPage'
                    ? const Icon(Icons.chat)
                    : const Icon(Icons.camera))
          else
            const SizedBox()
        ],
      ),
    );
  }
}
