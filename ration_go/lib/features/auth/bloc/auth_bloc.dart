import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:meta/meta.dart';
import 'package:ration_go/common/server.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Dio _dio;
  AuthBloc(this._dio) : super(AuthInitial()) {
    on<SendOtpEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _dio.post(
          '${ServerConstants.server_url}/auth/send_otp',
          data: {'ration_card_id': event.rationCardId},
        );

        if (response.statusCode == 200) {
          emit(SendOtpSuccess());
        } else {
          emit(SendOtpFailure('Failed to send OTP'));
        }
      } catch (e) {
        emit(SendOtpFailure(e.toString()));
      }
    });

    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final response = await _dio.post(
          '${ServerConstants.server_url}/auth/login',
          data: {
            'ration_card_id': event.rationCardId,
            'otp': event.otp,
          },
        );

        if (response.statusCode == 200) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString(
              "access_token", response.data['access_token'].toString());
          print(response.data['access_token'].toString());

          emit(LoginSuccess());
          Get.offAllNamed('/home');
        } else {
          emit(LoginFailure('Failed to login'));
        }
        print(response);
      } catch (e) {
        print(e);
        emit(LoginFailure(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.remove(
            "access_token"); // Remove the access token from SharedPreferences

        emit(LogoutSuccess()); // Emit the logout success state
      } catch (e) {
        emit(LoginFailure(
            e.toString())); // Reuse the failure state for simplicity
      }
    });
  }
}
