import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/light_theme/light_color.dart';
import 'package:news_app/feathures/profile/bottom_sheet/profile_info_bottom_sheet.dart';
import 'package:news_app/feathures/profile/cubit/profile_cubit.dart';
import 'package:news_app/core/constants/app_size.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/feathures/auth/login_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit()..getUserData(),
      child: Scaffold(
        appBar: AppBar(title: Text("Profile"), centerTitle: true),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSize.w16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: AppSize.h20),
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: state.selectedImage == null
                                  ? AssetImage("assets/images/abdo.png")
                                  : FileImage(File(state.selectedImage!.path)),
                              radius: AppSize.r60,
                            ),
                            GestureDetector(
                              onTap: () async {
                                context.read<ProfileCubit>().pickImage(
                                  ImageSource.gallery,
                                );
                              },
                              child: Container(
                                width: AppSize.w34,
                                height: AppSize.h34,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    AppSize.r100,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.camera_enhance_outlined,
                                  size: AppSize.r18,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppSize.h8),
                        Text(state.userName ?? "User Name"),
                      ],
                    ),
                  ),
                  SizedBox(height: AppSize.h16),
                  Text("Profile Info"),
                  // SizedBox(height: AppSize.h8),
                  _buildProfileItem("Profile Info", Icons.person, () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      backgroundColor: Colors.transparent,
                      builder: (context) {
                        return ProfileInfoBottomSheet();
                      },
                    ).then((value) {
                      if (!context.mounted) return;
                      context.read<ProfileCubit>().getUserData();
                    });
                  }),
                  _buildProfileItem("Language", Icons.language, () {}),
                  _buildProfileItem(
                    state.countryName ?? "Country",
                    Icons.flag_outlined,
                    () {
                      showCountryPicker(
                        context: context,
                        onSelect: (Country country) {
                          context.read<ProfileCubit>().saveCountry(country);
                        },
                      );
                    },
                  ),
                  _buildProfileItem(
                    "Terms & Conditions",
                    Icons.list_alt,
                    () {},
                  ),
                  _buildProfileItem(
                    "Log Out",
                    Icons.logout,
                    () async {
                      await UserRepository().delete();

                      await PreferencesManeger().clear();
                      if (!context.mounted) return;

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    color: LightColor.primaryColor,
                    withDivider: false,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

Widget _buildProfileItem(
  String title,
  IconData icon,
  VoidCallback onTap, {
  Color color = const Color(0xff161f1b),
  bool withDivider = true,
}) {
  return Column(
    children: [
      ListTile(
        onTap: onTap,
        contentPadding: EdgeInsets.zero,

        leading: Icon(icon, size: AppSize.r18, color: color),

        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: AppSize.sp16,
            color: color,
          ),
        ),

        trailing: Icon(
          Icons.arrow_forward_ios,
          size: AppSize.r18,
          color: color,
        ),
      ),

      if (withDivider) Divider(color: Colors.grey.shade300, height: 1),
    ],
  );
}
