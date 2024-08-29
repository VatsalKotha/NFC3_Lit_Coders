part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class SendOtpSuccess extends AuthState {}

final class SendOtpFailure extends AuthState {
  final String error;
  SendOtpFailure(this.error);
}

final class LoginSuccess extends AuthState {}

final class LoginFailure extends AuthState {
  final String error;
  LoginFailure(this.error);
}

final class LogoutSuccess extends AuthState {}
