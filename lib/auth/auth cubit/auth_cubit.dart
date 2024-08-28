import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:the_app/auth/service/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService authService;
  AuthCubit({required this.authService}) : super(AuthInitial());

  signUpWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthLoading());
    try {
      User? user = await authService.emailPasswordSignup(
          email: email, password: password);
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailed());
      }
    } catch (e) {
      emit(AuthFailed());
    }
  }
  loginWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(AuthLoading());
    try {
      User? user = await authService.loginWithEmailAndPassword(
          email: email, password: password);
      if (user != null) {
        emit(AuthSuccess());
      } else {
        emit(AuthFailed());
      }
    } catch (e) {
      emit(AuthFailed());
    }
  }
}
