part of 'auth_cubit.dart';

class AuthState extends Equatable {
  const AuthState({
    this.status = RequestStatus.initial,
    this.errorMessage,
    this.userModel,
  });
  final RequestStatus status;
  final String? errorMessage;
  final UserModel? userModel;
  @override
  List<Object?> get props => [status, errorMessage, userModel];

  AuthState copyWith({
    RequestStatus? status,
    String? errorMessage,
    UserModel? userModel,
  }) {
    return AuthState(
      status: status ?? this.status,
      errorMessage: errorMessage,
      userModel: userModel ?? this.userModel,
    );
  }
}
