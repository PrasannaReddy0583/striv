import 'package:equatable/equatable.dart';
import 'package:striv/features/auth/domain/entities/auth_tokens.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthLoginSuccess extends AuthState {
  final AuthTokens tokens;

  const AuthLoginSuccess(this.tokens);

  @override
  List<Object?> get props => [tokens];
}

class AuthSignupSuccess extends AuthState {
  const AuthSignupSuccess();
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
