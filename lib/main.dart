import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/light_theme/light_theme.dart';
import 'package:news_app/feathures/bookmark/data/bookmark_repository.dart';
import 'package:news_app/feathures/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ScreenUtil.ensureScreenSize();
  await UserRepository().init();
  await BookmarkRepository().init();

  await PreferencesManeger().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 832),
      minTextAdapt: true,
      builder: (cxt, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: lightTheme,
          home: SplashScreen(),
        );
      },
    );
  }
}
