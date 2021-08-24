import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'platform_specific_widget.dart';

class PlatformScaffoldWidget
    extends PlatformWidget<CupertinoTabScaffold, Scaffold> {
  const PlatformScaffoldWidget({
    required this.tabBuilder,
    required this.tabBar,
    this.appBar,
    this.body,
    this.bottomNavigationBar,
    this.backgroundColor,
  });

  final PreferredSizeWidget? appBar;
  final Widget? body;
  final Widget? bottomNavigationBar;
  final CupertinoTabBar tabBar;
  final IndexedWidgetBuilder tabBuilder;
  final Color? backgroundColor;

  @override
  CupertinoTabScaffold createIosWidget(BuildContext context) =>
      CupertinoTabScaffold(
        tabBar: tabBar,
        tabBuilder: tabBuilder,
        backgroundColor: backgroundColor,
      );

  @override
  Scaffold createAndroidWidget(BuildContext context) => Scaffold(
        appBar: appBar,
        body: body,
        backgroundColor: backgroundColor,
        bottomNavigationBar: bottomNavigationBar,
      );
}
