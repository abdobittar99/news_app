import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:news_app/core/datasource/local_data/preferences_maneger.dart';
import 'package:news_app/core/datasource/local_data/user_repository.dart';
import 'package:news_app/core/enums/request_status_enums.dart';
import 'package:news_app/core/models/user_model.dart';
import 'package:news_app/feathures/auth/repository/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthState());
  final AuthRepository authRepository;

  Future<void> login({required String email, required String password}) async {
    try {
      emit(state.copyWith(status: RequestStatus.loading, errorMessage: null));
      final userModel = await authRepository.login(
        email: email,
        password: password,
      );

      if (userModel.accessToken != null) {
        emit(
          state.copyWith(status: RequestStatus.loaded, userModel: userModel),
        );
        PreferencesManeger().setBool("is_logged_in", true);
      }
    } catch (e) {
      emit(
        state.copyWith(status: RequestStatus.error, errorMessage: e.toString()),
      );
    }
  }

  void register({
    required String email,
    required String password,
    required String userName,
  }) async {
    emit(state.copyWith(status: RequestStatus.loading, errorMessage: null));

    await Future.delayed(Duration(seconds: 1));
    final String? error = await UserRepository().sginUp(
      email: email,
      password: password,
      userName: userName,
    );

    if (error != null) {
      emit(state.copyWith(status: RequestStatus.error, errorMessage: error));
      return;
    }

    await PreferencesManeger().setBool("is_logged_in", true);
    emit(state.copyWith(status: RequestStatus.loaded, errorMessage: null));
  }
}
