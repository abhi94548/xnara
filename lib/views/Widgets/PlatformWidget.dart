import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class PlatformWidget<I extends Widget, A extends Widget>
    extends StatelessWidget {
  const PlatformWidget ({Key? key}) : super (key : key);


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