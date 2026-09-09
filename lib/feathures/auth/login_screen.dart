import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/core/shared_widget/app_button.dart';
import 'package:news_app/core/shared_widget/app_form_field.dart';
import 'package:news_app/feathures/auth/auth_card.dart';
import 'package:news_app/feathures/auth/register_screen.dart';
import 'package:news_app/feathures/home_layout/home_layout_scraan.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey();

  String? errorMessage;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthCard(
        child: Form(
          key: _form,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  "assets/images/logo.png",
                  height: AppSize.h45,
                ),
              ),
              SizedBox(height: AppSize.h24),

              Text(
                "Welcome to Newts",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: AppSize.sp20,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: AppSize.h16),

              AppFormField(
                titel: "Email",
                hintText: "Abdo@gmail.com",
                controller: emailController,
                onChanged: (value) {},
                validator: (v) {
                  return AppValidators.email(v);
                },
              ),

              SizedBox(height: AppSize.h12),

              AppFormField(
                titel: "Password",
                obscureText: true,
                controller: passwordController,
                onChanged: (value) {},
                validator: (v) {
                  return AppValidators.password(v);
                },
              ),
              if (errorMessage != null)
                Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSize.h8),
                  child: Text(
                    errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(height: AppSize.h20),

              AppButton(
                isLoading: isLoading,
                text: "Sign in",
                onPressed: () {
                  if (_form.currentState?.validate() ?? false) {
                    _login();
                  }
                },
              ),

              SizedBox(height: AppSize.h24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account ?",
                    style: TextStyle(
                      color: Color(0xff141414),
                      fontSize: AppSize.sp14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: LightColor.primaryColor,
                        fontSize: AppSize.sp14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });

    await Future.delayed(Duration(seconds: 2));
    final String? error = UserRepository().login(
      emailController.text,
      passwordController.text,
    );
    if (error != null) {
      setState(() {
        errorMessage = error;
        isLoading = false;
      });
      return;
    }
    await PreferencesManeger().setBool("is_logged_in", true);

    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeLayoutScraan()),
    );
  }
}
