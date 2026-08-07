import 'package:flutter/material.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/core/shared_widget/app_button.dart';
import 'package:news_app/core/shared_widget/app_form_field.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image(
                  image: AssetImage("assets/images/logo.png"),
                  height: 45,
                ),
              ),
              SizedBox(height: 24),
              Text(
                "Welcome to Newts",
                style: TextStyle(
                  color: Color(0xff363636),
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 16),

              AppFormField(
                titel: "Email",
                hintText: "Abdo@gmail.com",
                controller: emailController,
                onChanged: (value) {},
                validator: (v) {
                  return AppValidators.email(v);
                },
              ),
              SizedBox(height: 12),

              AppFormField(
                titel: "Password",
                suffixIcon: isVisible ? Icons.visibility_off : Icons.visibility,
                onSuffixPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                onChanged: (value) {},
                validator: (v) {
                  return AppValidators.password(v);
                },
              ),

              SizedBox(height: 20),
              AppButton(text: "Sign in", onPressed: () {}),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account ?",
                    style: TextStyle(
                      color: Color(0xff141414),
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "Sign up",
                      style: TextStyle(
                        color: LightColor.primaryColor,
                        fontSize: 14,
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
}
