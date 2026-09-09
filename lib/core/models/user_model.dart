import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel {
  @HiveField(0)
  String? email;
  @HiveField(1)
  String? passowrd;
  @HiveField(2)
  String? name;
  @HiveField(3)
  String? countryName;
  @HiveField(4)
  String? countryCode;

  UserModel({
    required this.email,
    required this.name,
    this.passowrd,
    this.countryName,
    this.countryCode,
  });

  UserModel copyWith({
    String? email,
    String? passowrd,
    String? name,
    String? countryName,
    String? countryCode,
  }) {
    return UserModel(
      email: email ?? this.email,
      passowrd: passowrd ?? this.passowrd,
      name: name ?? this.name,
      countryName: countryName ?? this.countryName,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      email: map["email"] as String,
      name: map["name"] as String,
      passowrd: map["password"],
      countryCode: map["countryCode"] as String,
      countryName: map["countryName"] as String,
    );
  }
}
