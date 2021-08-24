import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../viewModels/HomePageViewModel.dart';
import '../../views/HomePage/HomePageBody.dart';
import '../../views/Widgets/HeadTextWidget.dart';
import '../../views/Widgets/LoadingTextWidget.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Future<Map<String, dynamic>?> foodList =
        Provider.of<HomePageViewModel>(context, listen: false).fetchFoods();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HeadTextWidget(headText: 'Foods List',routeName : 'homePage'),
            Flexible(
              child: FutureBuilder(
                future: foodList,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.data == null) {
                      return const LoadingTextWidget(
                          loadingText:
                              'Something went wrong. Internet or server error');
                    } else {
                      return HomePageBody(
                          context: context, model: snapshot.data as Map<String,dynamic>);
                    }
                  } else if (snapshot.connectionState ==
                          ConnectionState.waiting ||
                      snapshot.connectionState == ConnectionState.waiting) {
                    return const LoadingTextWidget(
                        loadingText: 'Loading Please Wait');
                  } else {
                    return HomePageBody(
                        context: context, model: snapshot.data as Map<String,dynamic>);
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
