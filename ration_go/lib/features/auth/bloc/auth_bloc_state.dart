part of 'auth_bloc_bloc.dart';

sealed class AuthBlocState {}

final class AuthBlocInitial extends AuthBlocState {}

final class AuthLoading extends AuthBlocState {}

final class SendOtpSuccess extends AuthBlocState {}

final class SendOtpFailure extends AuthBlocState {
  final String error;

  SendOtpFailure(this.error);
}

final class LoginSuccess extends AuthBlocState {}

final class LoginFailure extends AuthBlocState {
  final String error;

  LoginFailure(this.error);
}

final class LogoutSuccess extends AuthBlocState {}
