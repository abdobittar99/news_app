import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:shimmer/shimmer.dart';

class TrendingNewsShimmer extends StatelessWidget {
  const TrendingNewsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.only(left: AppSize.w12),
      itemCount: 6,
      separatorBuilder: (context, index) => SizedBox(width: AppSize.w12),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            height: AppSize.h140,
            width: AppSize.w240,
            color: Colors.red,
          ),
        );
      },
    );
  }
}
