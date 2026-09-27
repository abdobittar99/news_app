import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/feathures/home/componants/news_item.dart';
import 'package:news_app/feathures/home/componants/shimmer/top_headline_shimmer.dart';
import 'package:news_app/feathures/home/cubit/home_cubit.dart';

class TopHeadline extends StatelessWidget {
  const TopHeadline({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        switch (state.topHeadlineStatus) {
          case RequestStatus.initial:
          case RequestStatus.loading:
            return TopHeadlineShimmer();
          case RequestStatus.error:
            return SliverToBoxAdapter(
              child: Center(child: Text(state.errorMessage!)),
            );
          case RequestStatus.loaded:
            return SliverList.builder(
              itemCount: state.newsTopHeadLineList.length,
              itemBuilder: (context, index) {
                final model = state.newsTopHeadLineList[index];
                return NewsItem(model: model);
              },
            );
        }
      },
    );
  }
}
