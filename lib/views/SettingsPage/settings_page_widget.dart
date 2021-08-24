import 'package:flutter/material.dart';

import '../../config.dart';
import '../Widgets/head_text_widget.dart';

class SettingsPageWidget extends StatelessWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadTextWidget(headText: 'Settings',routeName : 'settings'),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.swap_vertical_circle,
                          size: 20,
                          color: AppConfig().iconColor,
                        ),
                        const SizedBox(
                          width: 8.0,
                        ),
                        const Text(
                          'Notification',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                    Switch(
                      value: true,
                      activeColor: AppConfig().primaryColor,
                      onChanged: (bool value) {
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
    );
  }
}
