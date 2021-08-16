import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;

abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  PlatformWidget ({Key? key}) : super (key : key);


  I createIosWidget(BuildContext context);

  A createAndroidWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS) {
      return createIosWidget(context);
    }
    //Returns Material design
    return createAndroidWidget(context);
  }

}