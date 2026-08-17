import 'package:flutter/material.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/feathures/home/componants/view_all_componatnts.dart';
import 'package:news_app/feathures/home/home_controller.dart';
import 'package:provider/provider.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, controller, child) {
        return SliverToBoxAdapter(
          child: Column(
            children: [
              ViewAllComponatnts(
                    titel: "Categories",
                    titleColor: Color(0xff141414),
                    onTap: () {},
                  ),
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12, bottom: 16),
                child: SizedBox(
                  height: 30,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: 12.0),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isSelected =
                          controller.selectedCategory == categories[index];
                      return InkWell(
                        onTap: () {
                          controller.updateSelectedCategory(
                            category: categories[index],
                          );
                        },
                        child: IntrinsicWidth(
                          child: Column(
                            children: [
                              Text(
                                categories[index][0].toUpperCase() +
                                    categories[index].substring(1),
                                style: TextStyle(
                                  color: Color(0xff363636),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 4),
                              if (isSelected)
                                Container(
                                  height: 2,
                                  color: LightColor.primaryColor,
                                ),
                            ],
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return SizedBox(width: 12);
                    },
                    itemCount: categories.length,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

final List<String> categories = [
  "business",
  "entertainment",
  "general",
  "health",
  "science",
  "sports",
  "technology",
];
