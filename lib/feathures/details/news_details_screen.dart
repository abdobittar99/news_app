import 'dart:math';

import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/extensions/date_time_extension.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/core/shared_widget/app_network_image.dart';
import 'package:news_app/feathures/home/models/news_articale_model.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen({super.key, required this.model});
  final NewsArticaleModel model;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text("News Details")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppSize.w16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSize.r4),
              child: AppNetworkImage(
                imageUrl: model.urlToImage,
                width: double.infinity,
                height: AppSize.h204,
              ),
            ),
            SizedBox(height: AppSize.h12),
            Text(
              model.description ?? "",
              style: TextStyle(
                fontSize: AppSize.sp20,
                fontWeight: FontWeight.w700,
                color: LightColor.textprimary,
              ),
            ),
            SizedBox(height: AppSize.h8),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipOval(
                  child: AppNetworkImage(
                    imageUrl: model.urlToImage,
                    width: AppSize.w24,
                    height: AppSize.h24,
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
                          fontSize: AppSize.sp14,
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
            SizedBox(height: AppSize.h12),
            Text(
              model.content ?? "",
              style: TextStyle(
                fontSize: AppSize.sp16,
                fontWeight: FontWeight.w400,
                color: LightColor.textsecond,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
