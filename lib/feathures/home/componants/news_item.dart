import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/shared_widget/app_network_image.dart';
import 'package:news_app/feathures/home/models/news_articale_model.dart';

class NewsItem extends StatelessWidget {
  const NewsItem({super.key, required this.model});
  final NewsArticaleModel model;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSize.w16,
        vertical: AppSize.h6,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSize.r10),
            child: AppNetworkImage(
              imageUrl: model.urlToImage,
              fit: BoxFit.cover,
              height: AppSize.h70,
              width: AppSize.w120,
            ),
          ),
          SizedBox(width: AppSize.w8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.title,
                  maxLines: 2,
                  style: TextStyle(
                    color: Color(0xff141414),
                    fontSize: AppSize.sp16,
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
                        width: AppSize.w20,
                        height: AppSize.h20,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: AppSize.w4),
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
                              fontSize: AppSize.sp12,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(width: AppSize.w4),
                          Text(
                            model.publishedAt.formateDateTime(),
                            style: TextStyle(
                              color: Color(0xff141414),
                              fontSize: AppSize.sp12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.bookmark_border_outlined,
                            color: Color(0xff363636),
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
  }
}
