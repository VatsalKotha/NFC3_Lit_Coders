import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ration_go/common/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_bloc_event.dart';
part 'auth_bloc_state.dart';

class AuthBlocBloc extends Bloc<AuthBlocEvent, AuthBlocState> {
  final Dio _dio;

  AuthBlocBloc(this._dio) : super(AuthBlocInitial()) {
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
        await prefs.remove("access_token");

        emit(LogoutSuccess());
      } catch (e) {
        emit(LoginFailure(e.toString()));
      }
    });
  }
}
