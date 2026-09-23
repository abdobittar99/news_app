import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/feathures/home/componants/categories_list.dart';
import 'package:news_app/feathures/home/componants/top_headline.dart';
import 'package:news_app/feathures/home/componants/trending_news.dart';
import 'package:news_app/feathures/home/cubit/home_cubit.dart';
import 'package:news_app/core/repository/news_repository.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(NewsRepository(ApiService())),
      child: Scaffold(
        body: CustomScrollView(
          slivers: [TrendingNews(), CategoriesList(), TopHeadline()],
        ),
      ),
    );
  }
}
