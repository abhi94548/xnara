import 'package:flutter/material.dart';
import '../views/HomePage/home_page_head_widget.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Object? arguments = settings.arguments;
    return MaterialPageRoute(builder: (_) => const HomePageWidget());
  }
}
