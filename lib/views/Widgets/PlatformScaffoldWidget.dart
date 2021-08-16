import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'PlatformWidget.dart';

class PlatformScaffoldWidget
    extends PlatformWidget<CupertinoTabScaffold, Scaffold> {

  PlatformScaffoldWidget(
      {this.appBar ,
      this.body,
      this.bottomNavigationBar,
      required this.tabBar,
      this.backgroundColor,
      required this.tabBuilder});

  final PreferredSizeWidget?  appBar;
  final Widget?  body;
  final Widget? bottomNavigationBar;
  final CupertinoTabBar tabBar;
  final IndexedWidgetBuilder tabBuilder;
  final Color? backgroundColor;


  @override
  CupertinoTabScaffold createIosWidget(BuildContext context) =>
      new CupertinoTabScaffold(
        tabBar: tabBar,
        tabBuilder: tabBuilder,
        backgroundColor: backgroundColor,
      );

  @override
  Scaffold createAndroidWidget(BuildContext context) => new Scaffold(
        appBar: appBar,
        body: body,
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
      );
}
