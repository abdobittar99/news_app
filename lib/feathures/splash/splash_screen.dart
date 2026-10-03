import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/feathures/auth/ui/login_screen.dart';
import 'package:news_app/feathures/home_layout/home_layout_scraan.dart';
import 'package:news_app/feathures/onboarding/ui/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _navigatorAfterSplash();
    super.initState();
  }

  void _navigatorAfterSplash() async {
    await Future.delayed(Duration(seconds: 1));
    final bool onboardingComplete =
        PreferencesManeger().getBool("Onboarding_complete") ?? false;
    final bool isLoggedIn =
        PreferencesManeger().getBool("is_logged_in") ?? false;
    final userHasToken = UserRepository().getUser()?.accessToken != null;
    if (!mounted) return;
    if (!onboardingComplete) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return OnboardingScreen();
          },
        ),
      );
    } else if (!isLoggedIn && !userHasToken) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return HomeLayoutScraan();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Image.asset(
        "assets/images/splash.png",
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
