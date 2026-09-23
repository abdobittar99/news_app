import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/feathures/auth/login_screen.dart';
import 'package:news_app/feathures/onboarding/cubit/onboarding_cubit.dart';
import 'package:news_app/feathures/onboarding/model/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OnboardingCubit>(
      create: (context) => OnboardingCubit(),
      child: Builder(
        builder: (context) {
          final controller = context.read<OnboardingCubit>();
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xffF5F5F5),

              actions: [
                BlocBuilder<OnboardingCubit, OnboardingState>(
                  builder: (context, state) {
                    return state.islastPage
                        ? SizedBox()
                        : TextButton(
                            onPressed: () {
                              _finished(context);
                            },
                            child: Text(
                              "Skip",
                              style: TextStyle(fontSize: AppSize.sp16),
                            ),
                          );
                  },
                ),
              ],
            ),

            body: Padding(
              padding: EdgeInsets.symmetric(
                vertical: AppSize.h20,
                horizontal: AppSize.w16,
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
                            SizedBox(height: AppSize.h24),
                            Text(
                              model.titel,
                              style: TextStyle(
                                fontSize: AppSize.sp20,
                                color: Color(0xff4E4B66),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(height: AppSize.h12),
                            Text(
                              model.description,
                              style: TextStyle(
                                fontSize: AppSize.sp16,
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
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return SmoothPageIndicator(
                        controller: controller.pageController,
                        count: 3,
                        effect: SwapEffect(activeDotColor: Color(0xffC53030)),
                      );
                    },
                  ),
                  SizedBox(height: AppSize.h10),
                  BlocBuilder<OnboardingCubit, OnboardingState>(
                    builder: (context, state) {
                      return ElevatedButton(
                        onPressed: () {
                          if (!state.islastPage) {
                            controller.pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          } else {
                            _finished(context);
                          }
                        },

                        child: Text(state.islastPage ? "Get Started" : "Next"),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _finished(BuildContext context) async {
    await PreferencesManeger().setBool("Onboarding_complete", true);
    if (!context.mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}
