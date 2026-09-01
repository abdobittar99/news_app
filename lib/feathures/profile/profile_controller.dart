import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:news_app/core/constants/storage_key.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/mixins/safe_notifi_mixin.dart';
import 'package:path_provider/path_provider.dart';

class ProfileController extends ChangeNotifier with SafeNotifi {
  late String username;
  String? userImageProf;
  bool isloading = true;
  XFile? saveImages;
  String? countryName;
  String? countryCode;

  void init() {
    loaduser();
  }

  void loadUsername() {
    username =
        PreferencesManeger().getString(StorageKey.username) ??
        PreferencesManeger().getString("email")!;
    safeNotifi();
  }

  void loaduser() async {
    username =
        PreferencesManeger().getString(StorageKey.username) ??
        PreferencesManeger().getString("email")!;
    userImageProf = PreferencesManeger().getString(StorageKey.userImage);
        countryName = PreferencesManeger().getString(StorageKey.countryName);
    countryCode = PreferencesManeger().getString(StorageKey.countryCode);

    isloading = false;
    safeNotifi();
  }

  void saveCountry(Country savedCountry) async{
    await PreferencesManeger().setString(StorageKey.countryName, savedCountry.name);
   await PreferencesManeger().setString(
      StorageKey.countryCode,
      savedCountry.countryCode,
    );
    countryName = savedCountry.name;
    countryCode = savedCountry.countryCode;
  }

  void pickImage(ImageSource source) async {
    saveImages = await ImagePicker().pickImage(source: source);

    if (saveImages != null) {
      final newPath = await _saveProfImage(saveImages!);
      userImageProf = newPath;
      safeNotifi();
    }
  }

  Future<String> _saveProfImage(XFile image) async {
    final appDir = await getApplicationDocumentsDirectory();

    final newFile = await File(image.path).copy("${appDir.path}/${image.name}");

    await PreferencesManeger().setString(StorageKey.userImage, newFile.path);

    return newFile.path;
  }
}
