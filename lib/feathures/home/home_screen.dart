import 'package:flutter/material.dart';
import 'package:news_app/feathures/home/home_controller.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeController>(
      create: (context) => HomeController(),
      child: Consumer<HomeController>(
        builder: (context, controller, child) {
          return Scaffold(
            body: (controller.errorMessage?.isNotEmpty ?? false)
                ? Center(child: Text(controller.errorMessage!))
                : controller.topHeadlineLoading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.newsTopHeadlineList.length,
                          itemBuilder: (context, index) {
                            return Text(
                              controller.newsTopHeadlineList[index].title,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
