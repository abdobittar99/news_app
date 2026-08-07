import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/feathures/auth/login_screen.dart';
import 'package:news_app/feathures/onboarding/controller/onboarding_controller.dart';
import 'package:news_app/feathures/onboarding/model/onboarding_model.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});
  void _finished(BuildContext context) async {
    await PreferencesManeger().setBool("Onboarding_complete", true);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => OnboardingController(),
      builder: (context, child) {
        final controller = context.read<OnboardingController>();
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xffF5F5F5),

            actions: [
              Consumer<OnboardingController>(
                builder: (context, value, child) {
                  return value.islastPage
                      ? SizedBox()
                      : TextButton(
                          onPressed: () {
                            _finished(context);
                          },
                          child: Text("Skip", style: TextStyle(fontSize: 16.0)),
                        );
                },
              ),
            ],
          ),

          body: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20.0,
              horizontal: 16.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    controller: controller.pageController,
                    onPageChanged: (index) {
                      controller.onboardingPage(index);
                    },
                    itemCount: OnboardingModel.onboardingList.length,
                    itemBuilder: (context, index) {
                      final OnboardingModel model =
                          OnboardingModel.onboardingList[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(model.image),
                          SizedBox(height: 24.0),
                          Text(
                            model.titel,
                            style: TextStyle(
                              fontSize: 20.0,
                              color: Color(0xff4E4B66),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: 12.0),
                          Text(
                            model.description,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xff6E7191),
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      );
                    },
                  ),
                ),
                Consumer<OnboardingController>(
                  builder: (context, value, child) {
                    return SmoothPageIndicator(
                      controller: value.pageController,
                      count: 3,
                      effect: SwapEffect(activeDotColor: Color(0xffC53030)),
                    );
                  },
                ),
                SizedBox(height: 10),
                Consumer<OnboardingController>(
                  builder: (context, value, child) {
                    return SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (!value.islastPage) {
                            controller.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _finished(context);
                          }
                        },

                        child: Text(value.islastPage ? "Get Started" : "Next"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
//TODO image size

// SizedBox(
//   height: MediaQuery.of(context).size.height * .3,
//   child: Image.asset(
//     model.image,
//     fit: BoxFit.contain,
//   ),
// )
