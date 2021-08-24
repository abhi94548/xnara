import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

import 'config.dart';
import 'models/ChatBot/HiveMessageModel.dart';
import 'viewModels/ChatUI/ChatHomeViewModel.dart';
import 'viewModels/HomePageViewModel.dart';
import 'views/ChatPage/chatHomePageWidget.dart';
import 'views/HomePage/homePageWidget.dart';
import 'views/MyUploadsPage/myUploadsPageWidget.dart';
import 'views/SettingsPage/settingsPageWidget.dart';
import 'views/Widgets/PlatformScaffoldWidget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final Directory directory = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(directory.path);
  Hive.registerAdapter(ChatModelHiveAdaptor());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primaryColor: AppConfig().primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<HomePageViewModel>(create: (_) => HomePageViewModel()),
            ChangeNotifierProvider<ChatHomeViewModel>(create: (_) => ChatHomeViewModel()),
          ],
          child: const NavigationTab(),
        ));
  }
}

class NavigationTab extends StatefulWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  _NavigationTabState createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab> {
  int _currentIndex = 0;
  final List<Widget> _children = <Widget>[
    const HomePageWidget(),
    const MyUploadsPageWidget(),
    const ChatHomePageWidget(),
    const SettingsPageWidget(),
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PlatformScaffoldWidget(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        // new
        currentIndex: _currentIndex,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedItemColor: AppConfig().primaryColor,
        unselectedFontSize: 14,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppConfig().home,
              backgroundColor: AppConfig().primaryColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.cloud_upload),
              label: AppConfig().myUploads,
              backgroundColor: AppConfig().primaryColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.support_agent),
              label: AppConfig().faq,
              backgroundColor: AppConfig().primaryColor),
          BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppConfig().setting,
              backgroundColor: AppConfig().primaryColor)
        ],
      ),
      tabBar: CupertinoTabBar(items: [
        BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.home), label: AppConfig().home),
        BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.cloud_upload),
            label: AppConfig().myUploads),
        BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.question_circle), label: AppConfig().faq),
        BottomNavigationBarItem(
            icon: const Icon(CupertinoIcons.settings), label: AppConfig().setting)
      ]),
      backgroundColor: AppConfig().primaryColor,
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return const HomePageWidget();
          case 1:
            return const MyUploadsPageWidget();
          case 2:
            return const ChatHomePageWidget();
          default:
            return const SettingsPageWidget();
        }
      },
    );
  }
}
