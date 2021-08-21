import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/views/HomePage/HomePageBody.dart';
import 'package:xnara/views/HomePage/Widgets/HomePageFloatingActionWidget.dart';
import '../../config.dart';
import '/viewModels/HomePageViewModel.dart';
import '../../views/Widgets/HeadTextWidget.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var foodList = Provider.of<HomePageViewModel>(context,listen: false).fetchFoods();
    return ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadTextWidget(headText: 'Foods List'),
                Flexible(
                  child: Consumer<HomePageViewModel>(
                    builder: (context, model, _) {
                      context.read<HomePageViewModel>().fetchFoods();
                      return model.foods.isEmpty
                          ? Center(
                              child: Text(
                                'Loading Please Wait...',
                                style: TextStyle(
                                  fontSize: 22,
                                  color: AppConfig().iconColor,
                                ),
                              ),
                            )
                          : HomePageBody(
                              context: context, model: model.foods);
                    },
                  ),
                )
              ],
            ),
          ),
        ),
        floatingActionButton: HomePageFloatingAction(),
      ),
    );
  }
}
