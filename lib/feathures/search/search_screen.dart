import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repository/news_repository.dart';
import 'package:news_app/feathures/details/news_details_screen.dart';
import 'package:news_app/feathures/search/cubit/search_cubit.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(NewsRepository(ApiService())),
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Search")),
        body: Padding(
          padding: EdgeInsets.all(AppSize.w16),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return Column(
                children: [
                  TextField(
                    controller: context.read<SearchCubit>().searchController,
                    onChanged: (value) {
                      context.read<SearchCubit>().getEverything();
                    },
                    decoration: InputDecoration(
                      hintText: "Search",
                      suffixIcon: Icon(
                        Icons.search_outlined,
                        color: Color(0xffA0A0A0),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemBuilder: (context, index) {
                        final model = state.newsEveryThingList[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: AppSize.h12),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return NewsDetailsScreen(model: model);
                                  },
                                ),
                              );
                            },
                            leading: Icon(
                              Icons.search_outlined,
                              color: Color(0xff6D6D6D),
                            ),
                            title: Text(
                              model.title,
                              style: TextStyle(
                                color: Color(0xff6D6D6D),
                                fontSize: AppSize.sp16,
                              ),
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: Color(0xffD1DAD6));
                      },
                      itemCount: state.newsEveryThingList.length,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
