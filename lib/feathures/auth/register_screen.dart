import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_service.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/core/shared_widget/app_button.dart';
import 'package:news_app/core/shared_widget/app_form_field.dart';
import 'package:news_app/feathures/auth/auth_card.dart';
import 'package:news_app/feathures/auth/cubit/auth_cubit.dart';
import 'package:news_app/feathures/auth/repository/auth_repository.dart';
import 'package:news_app/feathures/home_layout/home_layout_scraan.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _form = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthCubit(AuthRepository(AuthApiService())),
        child: AuthCard(
          child: Form(
            key: _form,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state.status == RequestStatus.loaded) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => HomeLayoutScraan()),
                  );
                }
              },
              builder: (context, state) {
                return Column(
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
                      text: "Sign up",
                      onPressed: () {
                        if (_form.currentState?.validate() ?? false) {
                          context.read<AuthCubit>().register(
                            email: emailController.text,
                            userName: userNameController.text,
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
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
