import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:news_app/core/constants/constants.dart';
import 'package:news_app/core/models/user_model.dart';

class UserRepository {
  UserRepository._internal();
  static final UserRepository _instance = UserRepository._internal();
  factory UserRepository() => _instance;

  Box<UserModel>? _userBox;
  Box<UserModel> get userBox {
    if (_userBox == null) {
      throw Exception('User not found');
    }
    return _userBox!;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(UserModelAdapter());
    }
    _userBox = await Hive.openBox(Constants.userBox);
  }

  Future<void> saveUser(UserModel user) async {
    await userBox.put(Constants.currentUser, user);
  }

  UserModel? getUser() {
    return userBox.get(Constants.currentUser);
  }

  Future<void> upadateUser({
    String? name,
    String? email,
    String? password,
    String? countryCode,
    String? countryName,
  }) async {
    UserModel? user = getUser();
    if (user != null) {
      final updatedUser = user.copyWith(
        email: email,
        name: name,
        passowrd: password,
        countryCode: countryCode,
        countryName: countryName,
      );
      await saveUser(updatedUser);
    }
  }

  Future<void> delete() async {
    await userBox.delete(Constants.currentUser);
  }

  Future<void> clear() async {
    await userBox.clear();
  }

  String? login(String email, String password) {
    final user = getUser();

    if (user == null) {
      return "Ao Account found please register";
    }
    if (user.email != email || user.passowrd != password) {
      return "Wrong email or password";
    }
    return null;
  }

  Future<String?> sginUp({
    required String email,
    required String password,
    required String userName,
  }) async {
    final user = getUser();

    if (user != null) {
      return "user already exist";
    }
    final newUser = UserModel(email: email, name: userName, passowrd: password);
    await saveUser(newUser);
    return null;
  }
}
