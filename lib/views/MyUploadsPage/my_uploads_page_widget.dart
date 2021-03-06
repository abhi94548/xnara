import 'package:flutter/material.dart';
import 'package:xnara/views/Widgets/loading_text_widget.dart';
import '../Widgets/head_text_widget.dart';

class MyUploadsPageWidget extends StatelessWidget {
  const MyUploadsPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const HeadTextWidget(
                headText: 'My Uploads', routeName: 'myUploadPage'),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            const LoadingTextWidget(loadingText: 'No Uploads yet')
          ],
        ),
      ),
    );
  }
}
