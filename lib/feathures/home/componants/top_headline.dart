import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/shared_widget/app_network_image.dart';
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
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: AppNetworkImage(
                          imageUrl: model.urlToImage,
                          fit: BoxFit.cover,
                          height: 70,
                          width: 120,
                        ),
                      ),
                      SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.title,
                              maxLines: 2,
                              style: TextStyle(
                                color: Color(0xff141414),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipOval(
                                  child: AppNetworkImage(
                                    imageUrl: model.urlToImage,
                                    width: 20,
                                    height: 20,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(width: 4),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Text(
                                        (model.author ?? "").substring(
                                          0,
                                          min((model.author ?? "").length, 10),
                                        ),
                                        style: TextStyle(
                                          color: Color(0xff141414),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        model.publishedAt.formateDateTime(),
                                        style: TextStyle(
                                          color: Color(0xff141414),
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }
}
