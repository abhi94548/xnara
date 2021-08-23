import 'package:flutter/material.dart';

import '../../config.dart';

class LoadingTextWidget extends StatelessWidget {
  const LoadingTextWidget({required this.loadingText});

  final String loadingText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          loadingText,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 18,
            color: AppConfig().iconColor,
          ),
        ),
      ),
    );
  }
}
