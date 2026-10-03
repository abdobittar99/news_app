import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/feathures/home/componants/categories_list.dart';
import 'package:news_app/feathures/home/componants/news_item.dart';
import 'package:news_app/feathures/home/cubit/home_cubit.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Categories"),
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
      ),

      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: AppSize.w16,
                  top: AppSize.h12,
                  bottom: AppSize.h10,
                ),
                child: SizedBox(
                  height: AppSize.h32,
                  child: ListView.separated(
                    padding: EdgeInsets.only(right: AppSize.w12),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      bool isSelected =
                          state.selectedCategory == categories[index];
                      return InkWell(
                        onTap: () {
                          context.read<HomeCubit>().updateSelectedCategory(
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
                                  fontSize: AppSize.sp16,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: AppSize.h2),
                              if (isSelected)
                                Container(
                                  height: AppSize.h2,
                                  color: LightColor.primaryColor,
                                ),
                            ],
                          ),
                        ),
                      );
                    },

                    separatorBuilder: (context, index) {
                      return SizedBox(width: AppSize.w12);
                    },
                    itemCount: categories.length,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.newsTopHeadLineList.length,
                  itemBuilder: (context, index) {
                    final model = state.newsTopHeadLineList[index];
                    return NewsItem(model: model);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
