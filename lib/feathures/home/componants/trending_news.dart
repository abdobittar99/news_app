import 'package:flutter/material.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/feathures/home/home_controller.dart';
import 'package:provider/provider.dart';

class TrendingNews extends StatelessWidget {
  const TrendingNews({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Stack(
        children: [
          SizedBox(
            height: 240,
            width: double.infinity,
            child: Image.asset(
              "assets/images/cover_image.png",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            top: 60,
            child: Column(
              children: [
                Text(
                  "NEWST",
                  style: TextStyle(
                    color: LightColor.primaryColor,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Trending News",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        "View all",
                        style: TextStyle(
                          decorationColor: Colors.white,
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.0),

                SizedBox(
                  height: 140,
                  child: Consumer<HomeController>(
                    builder: (context, controller, child) {
                      return (controller.errorMessage?.isNotEmpty ?? false)
                          ? Center(child: Text(controller.errorMessage!))
                          : controller.topHeadlineLoading
                          ? const Center(child: CircularProgressIndicator())
                          : ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemCount: controller.newsEveryThingList.length,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: 12.0),
                              itemBuilder: (context, index) {
                                final imageUrl = controller
                                    .newsEveryThingList[index]
                                    .urlToImage;

                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: imageUrl.isNotEmpty
                                      ? Image.network(
                                          imageUrl,
                                          width: 240,
                                          height: 140,
                                          fit: BoxFit.cover,

                                          loadingBuilder:
                                              (
                                                context,
                                                child,
                                                loadingProgress,
                                              ) {
                                                if (loadingProgress == null) {
                                                  return child;
                                                }

                                                return const SizedBox(
                                                  width: 240,
                                                  height: 140,
                                                  child: Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ),
                                                );
                                              },

                                          errorBuilder:
                                              (context, error, stackTrace) {
                                                return _imagePlaceholder();
                                              },
                                        )
                                      : _imagePlaceholder(),
                                );
                              },
                            );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Image.asset(
      "assets/images/placeholder.png",
      width: 240,
      height: 140,
      fit: BoxFit.cover,
    );
  }
}
