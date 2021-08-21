import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:path_provider/path_provider.dart' as pathProvider;
import 'package:xnara/viewModels/ChatUIViewModel.dart';
import 'package:xnara/viewModels/ImageUploadViewModel.dart';
import '/views/Widgets/PlatformScaffoldWidget.dart';
import 'config.dart';
import 'models/ChatBot/HiveMessageModel.dart';
import 'viewModels/HomePageViewModel.dart';
import 'views/ChatPage/chatHomePageWidget.dart';
import 'views/HomePage/homePageWidget.dart';
import 'views/MyUploadsPage/myUploadsPageWidget.dart';
import 'views/SettingsPage/settingsPageWidget.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory directory = await pathProvider.getApplicationDocumentsDirectory();
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
          ChangeNotifierProvider(create: (_) => HomePageViewModel()),
          ChangeNotifierProvider(create: (_) => ChatUIViewModel()),
          ChangeNotifierProvider(create: (_) => ImageUploadViewModel()),
        ],
        child: NavigationTab(),
      ),
    );
  }
}

class NavigationTab extends StatefulWidget {
  const NavigationTab({Key? key}) : super(key: key);

  @override
  _NavigationTabState createState() => _NavigationTabState();
}

class _NavigationTabState extends State<NavigationTab> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomePageWidget(),
    MyUploadsPageWidget(),
    ChatHomePageWidget(),
    SettingsPageWidget(),
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
          onTap: onTabTapped, // new
          currentIndex: _currentIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: AppConfig().primaryColor,
          enableFeedback: false,
          unselectedFontSize: 14,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: AppConfig().home,
                backgroundColor: AppConfig().primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.cloud_upload),
                label: AppConfig().myUploads,
                backgroundColor: AppConfig().primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.support_agent),
                label: AppConfig().faq,
                backgroundColor: AppConfig().primaryColor),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppConfig().setting,
                backgroundColor: AppConfig().primaryColor)
          ],
        ),
        tabBar: CupertinoTabBar(items: [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: AppConfig().home),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cloud_upload),
              label: AppConfig().myUploads),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.question_circle),
              label: AppConfig().faq),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), label: AppConfig().setting)
        ]),
        backgroundColor: AppConfig().primaryColor,
        tabBuilder: (context, index) {
          switch (index) {
            case 0:
              return HomePageWidget();
            case 1:
              return MyUploadsPageWidget();
            case 2:
              return ChatHomePageWidget();
            default:
              return SettingsPageWidget();
          }
        });
  }
}
