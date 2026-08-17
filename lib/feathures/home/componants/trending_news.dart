import 'package:flutter/material.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/core/shared_widget/app_network_image.dart';
import 'package:news_app/feathures/home/componants/shimmer/trending_news_shimmer.dart';
import 'package:news_app/feathures/home/componants/view_all_componatnts.dart';
import 'package:news_app/feathures/home/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 285,
        child: Stack(
          children: [
            SizedBox(
              height: 240,
              width: double.infinity,
              child: Image.asset(
                "assets/images/cover_image.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: 60,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: TextStyle(
                      color: LightColor.primaryColor,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4),
                  ViewAllComponatnts(titel: "Trendeing", onTap: () {}),
                  SizedBox(height: 12.0),

                  SizedBox(
                    height: 140,
                    child: Consumer<HomeController>(
                      builder: (context, controller, child) {
                        switch (controller.everythingStatus) {
                          case RequestStatusEnums.loading:
                            return TrendingNewsShimmer();
                          case RequestStatusEnums.error:
                            return Center(
                              child: Text(controller.errorMessage!),
                            );
                          case RequestStatusEnums.loaded:
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(left: 12.0),
                              itemCount: controller.newsEveryThingList
                                  .take(3)
                                  .length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 12.0),
                              itemBuilder: (context, index) {
                                final model =
                                    controller.newsEveryThingList[index];

                                return SizedBox(
                                  width: 240,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Stack(
                                      children: [
                                        AppNetworkImage(
                                          imageUrl: model.urlToImage,
                                          width: 240,
                                          height: 140,
                                          fit: BoxFit.cover,
                                        ),
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                begin:
                                                    AlignmentGeometry.topCenter,
                                                end:
                                                    AlignmentGeometry.bottomEnd,
                                                colors: [
                                                  Colors.black.withValues(
                                                    alpha: 0.2,
                                                  ),
                                                  Colors.black.withValues(
                                                    alpha: 0.45,
                                                  ),
                                                  Colors.black.withValues(
                                                    alpha: 0.7,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          right: 10,
                                          left: 10,
                                          bottom: 10,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                model.title,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  color: Color(0xffFFFCFC),
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      children: [
                                                        ClipOval(
                                                          child:
                                                              AppNetworkImage(
                                                                imageUrl: model
                                                                    .urlToImage,
                                                                width: 28,
                                                                height: 28,
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                        ),
                                                        SizedBox(width: 2),
                                                        Expanded(
                                                          child: Text(
                                                            model.author ?? "",
                                                            style: TextStyle(
                                                              color: Color(
                                                                0xffFFFCFC,
                                                              ),
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                            maxLines: 1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Text(
                                                    model.publishedAt
                                                        .formateDateTime(),

                                                    style: TextStyle(
                                                      color: Color(0xffFFFcfc),
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
