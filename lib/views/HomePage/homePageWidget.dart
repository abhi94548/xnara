import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:xnara/views/HomePage/Widgets/HomePageFloatingActionWidget.dart';
import '/viewModels/HomePageViewModel.dart';
import '../../views/Widgets/HeadTextWidget.dart';

class HomePageWidget extends StatelessWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomePageViewModel(),
      child: Scaffold(
        body: Consumer<HomePageViewModel>(
          builder: (context, model, _) {
            context.read<HomePageViewModel>().fetchFoods();
            print(context.read<HomePageViewModel>().loading.toString());
            return SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadTextWidget(headText: 'Foods List'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: HomePageFloatingAction(),
      ),
    );
  }
}
