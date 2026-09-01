import 'package:flutter/material.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/shared_widget/app_button.dart';
import 'package:news_app/core/shared_widget/app_form_field.dart';

class ProfileInfoBottomSheet extends StatefulWidget {
  const ProfileInfoBottomSheet({super.key});

  @override
  State<ProfileInfoBottomSheet> createState() => _ProfileInfoBottomSheetState();
}

class _ProfileInfoBottomSheetState extends State<ProfileInfoBottomSheet> {
  final TextEditingController userNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
    _loadUserdata();
  }

  void _loadUserdata() {
    userNameController.text =
        PreferencesManeger().getString(StorageKey.username) ?? "";
    emailController.text =
        PreferencesManeger().getString(StorageKey.email) ?? "";
  }

  void _saveData() async {
    if (_key.currentState?.validate() ?? false) {
      await PreferencesManeger().setString(
        StorageKey.username,
        userNameController.text,
      );
      await PreferencesManeger().setString(
        StorageKey.email,
        emailController.text,
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
        color: Color(0xffF5F5F5),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: AppSize.h16,
          right: AppSize.w16,
          left: AppSize.w16,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSize.h16,
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _key,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: AppSize.w34,
                    height: AppSize.h4,
                    decoration: BoxDecoration(
                      color: Color(0xff363636),
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ),
                SizedBox(height: AppSize.h32),
                Text("Profile Info"),
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
                SizedBox(height: AppSize.h40),

                AppButton(
                  text: "Save",
                  onPressed: () {
                    _saveData();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
