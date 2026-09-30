import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_config.dart';
import 'package:news_app/core/datasource/remote_data/auth/auth_api_service.dart';
import 'package:news_app/core/models/user_model.dart';

class AuthRepository {
  AuthRepository(this.apiService);

  final AuthApiService apiService;

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final response = await apiService.post(
      endpoint: AuthApiConfig.login,
      body: {"username": email, "password": password},
    );

    final UserModel model = UserModel.fromAuthResponse(response, email);
    await _saveUserToLocal(model);

    return model;
  }

  Future<void> _saveUserToLocal(UserModel model) async {
    await UserRepository().saveUser(model);
  }
}
