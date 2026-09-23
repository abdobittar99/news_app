import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/core/shared_widget/app_network_image.dart';
import 'package:news_app/feathures/details/news_details_screen.dart';
import 'package:news_app/feathures/home/componants/shimmer/trending_news_shimmer.dart';
import 'package:news_app/feathures/home/componants/view_all_componatnts.dart';
import 'package:news_app/feathures/home/cubit/home_cubit.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: AppSize.h290,
        child: Stack(
          children: [
            SizedBox(
              height: AppSize.h240,
              width: double.infinity,
              child: Image.asset(
                "assets/images/cover_image.png",
                fit: BoxFit.cover,
              ),
            ),
            Positioned.fill(
              top: AppSize.h60,
              child: Column(
                children: [
                  Text(
                    "NEWST",
                    style: TextStyle(
                      color: LightColor.primaryColor,
                      fontSize: AppSize.sp26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppSize.h4),
                  ViewAllComponatnts(titel: "Trendeing", onTap: () {}),
                  SizedBox(height: AppSize.h12),

                  SizedBox(
                    height: AppSize.h140,
                    child: BlocBuilder<HomeCubit, HomeState>(
                      builder: (context, state) {
                        switch (state.everythingStatus) {
                          case RequestStatusEnums.loading:
                            return TrendingNewsShimmer();
                          case RequestStatusEnums.error:
                            return Center(child: Text(state.errorMessage!));
                          case RequestStatusEnums.loaded:
                            return ListView.separated(
                              scrollDirection: Axis.horizontal,
                              padding: EdgeInsets.only(left: AppSize.w12),
                              itemCount: state.newsEverythingList
                                  .take(3)
                                  .length,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: AppSize.w12),
                              itemBuilder: (context, index) {
                                final model = state.newsEverythingList[index];

                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return NewsDetailsScreen(
                                            model: model,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  child: SizedBox(
                                    width: AppSize.w240,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                        AppSize.r12,
                                      ),
                                      child: Stack(
                                        children: [
                                          AppNetworkImage(
                                            imageUrl: model.urlToImage,
                                            width: AppSize.w240,
                                            height: AppSize.h140,
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned.fill(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: AlignmentGeometry
                                                      .topCenter,
                                                  end: AlignmentGeometry
                                                      .bottomEnd,
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
                                            right: AppSize.w10,
                                            left: AppSize.w10,
                                            bottom: AppSize.h10,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  model.title,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                    color: Color(0xffFFFCFC),
                                                    fontSize: AppSize.sp14,
                                                    fontWeight: FontWeight.w700,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                SizedBox(height: AppSize.h4),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          ClipOval(
                                                            child: AppNetworkImage(
                                                              imageUrl: model
                                                                  .urlToImage,
                                                              width:
                                                                  AppSize.w28,
                                                              height:
                                                                  AppSize.h28,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: AppSize.w2,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              model.author ??
                                                                  "",
                                                              style: TextStyle(
                                                                color: Color(
                                                                  0xffFFFCFC,
                                                                ),
                                                                fontSize:
                                                                    AppSize
                                                                        .sp14,
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
                                                        color: Color(
                                                          0xffFFFcfc,
                                                        ),
                                                        fontSize: AppSize.sp14,
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
