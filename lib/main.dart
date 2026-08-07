import 'package:flutter/material.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/light_theme/light_theme.dart';
import 'package:news_app/feathures/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferencesManeger().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: lightTheme,
      home: SplashScreen(),
    );
  }
}
