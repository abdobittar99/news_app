import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/repository/news_repository.dart';
import 'package:news_app/feathures/search/search_controller.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchScreenController(NewsRepository(ApiService())),
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Search")),
        body: Padding(
          padding: EdgeInsets.all(AppSize.w16),
          child: Consumer<SearchScreenController>(
            builder: (context, controller, child) {
              return Column(
                children: [
                  TextField(
                    controller: controller.searchController,
                    onChanged: (value) {
                      controller.getEverything();
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
                        final model = controller.newsEveryThingList[index];
                        return Padding(
                          padding: EdgeInsets.only(bottom: AppSize.h12),
                          child: ListTile(
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
                      itemCount: controller.newsEveryThingList.length,
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
