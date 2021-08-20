import 'package:flutter/material.dart';


class HeadTextWidget extends StatelessWidget {
  HeadTextWidget({required this.headText});

  final String headText;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Text(
          headText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 35
          ),
        ),
      ),
    );
  }
}
