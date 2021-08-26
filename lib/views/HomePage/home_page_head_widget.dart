import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../helper/error_handler.dart';

import '../../viewModels/home_page_view_model.dart';
import '../Widgets/head_text_widget.dart';
import '../Widgets/loading_text_widget.dart';
import 'home_page_body_widget.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<HomePageViewModel>(context,listen: false).fetchFoods();
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const HeadTextWidget(headText: 'Foods List', routeName: 'homePage'),
            Flexible(
              child: Consumer<HomePageViewModel>(
                builder: (BuildContext context, HomePageViewModel model, _) {
                  if (model.state == HomeNotifierState.loading) {
                    return const LoadingTextWidget(
                        loadingText: 'Loading Please Wait');
                  } else {
                    return model.foodList.fold(
                        (ShowError error) => LoadingTextWidget(
                            loadingText: error.message.toString()),
                        (Map<String, dynamic> success) => HomePageBody(
                              context: context,
                              foodModel: success,
                            ));
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
