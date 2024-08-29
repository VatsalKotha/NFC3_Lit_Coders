part of 'auth_bloc_bloc.dart';

sealed class AuthBlocEvent {}

final class SendOtpEvent extends AuthBlocEvent {
  final String rationCardId;

  SendOtpEvent(this.rationCardId);
}

final class LoginEvent extends AuthBlocEvent {
  final String rationCardId;
  final String otp;

  LoginEvent(this.rationCardId, this.otp);
}

final class LogoutEvent extends AuthBlocEvent {}
