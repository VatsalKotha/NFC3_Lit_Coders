part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

final class SendOtpEvent extends AuthEvent {
  final String rationCardId;
  SendOtpEvent(this.rationCardId);
}

final class LoginEvent extends AuthEvent {
  final String rationCardId;
  final String otp;
  LoginEvent(this.rationCardId, this.otp);
}

final class LogoutEvent extends AuthEvent {}
