import 'package:flutter/material.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/feathures/home/componants/trending_news.dart';
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
          return Scaffold(body: Column(children: [TrendingNews()]));
        },
      ),
    );
  }
}
