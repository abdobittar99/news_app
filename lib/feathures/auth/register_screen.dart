import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/core/shared_widget/app_button.dart';
import 'package:news_app/core/shared_widget/app_form_field.dart';
import 'package:news_app/feathures/auth/auth_card.dart';
import 'package:news_app/feathures/home_layout/home_layout_scraan.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

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
                titel: "User Name",
                hintText: "Abdo Bittar",
                controller: userNameController,
                onChanged: (value) {},
                validator: (v) {
                  return AppValidators.required(v);
                },
              ),

              SizedBox(height: AppSize.h12),

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
              SizedBox(height: AppSize.h12),

              AppFormField(
                titel: "Confirm Password",
                controller: confirmPasswordController,
                obscureText: true,
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
                text: "Sign up",
                onPressed: () {
                  if (_form.currentState?.validate() ?? false) {
                    _register();
                  }
                },
              ),

              SizedBox(height: AppSize.h24),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account ?",
                    style: TextStyle(
                      color: Color(0xff141414),
                      fontSize: AppSize.sp14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sign in",
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

  void _register() async {
    setState(() {
      errorMessage = null;
      isLoading = true;
    });
    await Future.delayed(Duration(seconds: 2));

    final savedEmail = PreferencesManeger().getString("email");
    if (savedEmail != null && savedEmail == emailController.text.trim()) {
      setState(() {
        errorMessage = "Email is already exist";
        isLoading = false;
      });
      return;
    }
    await PreferencesManeger().setString(
      "userName",
      userNameController.text.trim(),
    );

    await PreferencesManeger().setString("email", emailController.text.trim());
    await PreferencesManeger().setString(
      "passowrd",
      passwordController.text.trim(),
    );
    await PreferencesManeger().setBool("is_logged_in", true);
    setState(() {
      errorMessage = null;
      isLoading = false;
    });
    if (!mounted) return;
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeLayoutScraan()),
    );
  }
}
