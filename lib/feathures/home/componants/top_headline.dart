import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/feathures/home/componants/news_item.dart';
import 'package:news_app/feathures/home/componants/shimmer/top_headline_shimmer.dart';
import 'package:news_app/feathures/home/home_controller.dart';
import 'package:provider/provider.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        switch (controller.topHeadlineStatus) {
          case RequestStatusEnums.loading:
            return TopHeadlineShimmer();
          case RequestStatusEnums.error:
            return SliverToBoxAdapter(
              child: Center(child: Text(controller.errorMessage!)),
            );
          case RequestStatusEnums.loaded:
            return SliverList.builder(
              itemCount: controller.newsTopHeadlineList.length,
              itemBuilder: (context, index) {
                final model = controller.newsTopHeadlineList[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
