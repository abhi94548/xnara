import 'package:flutter/material.dart';

import '../../../config.dart';

class ImageUploadAppBarWidget extends StatelessWidget {
  const ImageUploadAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppConfig().primaryColor,
      leading: IconButton(
        onPressed: () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
      title: const Text('Predictions'),
    );
  }
}
