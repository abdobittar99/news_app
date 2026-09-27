import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/datasource/remote_data/api_service.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/core/shared_widget/app_button.dart';
import 'package:news_app/core/shared_widget/app_form_field.dart';
import 'package:news_app/feathures/auth/auth_card.dart';
import 'package:news_app/feathures/auth/cubit/auth_cubit.dart';
import 'package:news_app/feathures/auth/register_screen.dart';
import 'package:news_app/feathures/auth/repository/auth_repository.dart';
import 'package:news_app/feathures/home_layout/home_layout_scraan.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository(ApiService())),
      child: Scaffold(
        body: AuthCard(
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state.status == RequestStatus.loaded) {
                PreferencesManeger().setBool("is_logged_in", true);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeLayoutScraan()),
                );
              }
            },
            builder: (context, state) {
              return Form(
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
                        return AppValidators.required(v);
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
                    if (state.errorMessage != null)
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: AppSize.h8),
                        child: Text(
                          state.errorMessage!,
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(height: AppSize.h20),

                    AppButton(
                      isLoading: state.status == RequestStatus.loading,
                      text: "Sign in",
                      onPressed: () {
                        if (_form.currentState?.validate() ?? false) {
                          // _login();
                          context.read<AuthCubit>().login(
                            email: emailController.text,
                            password: passwordController.text,
                          );
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
              );
            },
          ),
        ),
      ),
    );
  }
}
