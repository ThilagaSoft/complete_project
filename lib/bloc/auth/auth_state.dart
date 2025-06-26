import 'package:map_pro/model/user_model.dart';

abstract class AuthState
{

}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class LoginSuccess extends AuthState
{
  final UserModel? user;
  LoginSuccess({this.user});
}
class RegisterSuccess extends AuthState
{
  final UserModel user;
  RegisterSuccess(this.user);
}
class SubmitState extends AuthState
{

}
class AuthError extends AuthState
{
  final String message;
  AuthError(this.message);
}
class TogglePasswordVisibilityState extends AuthState
{
  final bool isPasswordVisible;
  TogglePasswordVisibilityState({required this.isPasswordVisible});
  AuthState copyWith({bool? isPasswordVisible})
  {
    return TogglePasswordVisibilityState(
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
    );
  }
}
