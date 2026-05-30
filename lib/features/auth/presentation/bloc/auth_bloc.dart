import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:striv/core/errors/failures.dart';
import 'package:striv/features/auth/domain/usecases/login_usecase.dart';
import 'package:striv/features/auth/domain/usecases/signup_usecase.dart';
import 'package:striv/features/auth/presentation/bloc/auth_event.dart';
import 'package:striv/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final SignupUseCase signupUseCase;

  AuthBloc({required this.loginUseCase, required this.signupUseCase})
      : super(const AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<SignupRequested>(_onSignupRequested);
    on<AuthReset>(_onAuthReset);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      final tokens = await loginUseCase(
        LoginParams(email: event.email, password: event.password),
      );
      emit(AuthLoginSuccess(tokens));
    } on ServerFailure catch (e) {
      emit(AuthFailure(e.message));
    } on NetworkFailure catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onSignupRequested(
    SignupRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    try {
      await signupUseCase(
        SignupParams(
          username: event.username,
          email: event.email,
          password: event.password,
        ),
      );
      emit(const AuthSignupSuccess());
    } on ServerFailure catch (e) {
      emit(AuthFailure(e.message));
    } on NetworkFailure catch (e) {
      emit(AuthFailure(e.message));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  void _onAuthReset(AuthReset event, Emitter<AuthState> emit) {
    emit(const AuthInitial());
  }
}
