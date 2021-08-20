import 'package:flutter/material.dart';
import '../../views/Widgets/HeadTextWidget.dart';

import '../../config.dart';

class MyUploadsPageWidget extends StatelessWidget {
  const MyUploadsPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadTextWidget(headText: 'My Uploads'),
                SizedBox(height: MediaQuery.of(context).size.height * 0.4,),
                Container(
                  child: Center(
                    child: Text(
                      'No Uploads Yet.',
                      style: TextStyle(
                        fontSize: 22,
                        color: AppConfig().iconColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
