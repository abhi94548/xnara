import 'package:flutter/material.dart';
import '../../views/Widgets/HeadTextWidget.dart';

import '../../config.dart';

class SettingsPageWidget extends StatelessWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

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
                HeadTextWidget(headText: 'Settings'),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.swap_vertical_circle,
                                size: 20,
                                color: AppConfig().iconColor,
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                'Notification',
                                style: TextStyle(fontSize: 18),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: true,
                          activeColor: AppConfig().primaryColor,
                          onChanged: (value) {
                            value = false;
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Divider(
                    color: AppConfig().iconColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
