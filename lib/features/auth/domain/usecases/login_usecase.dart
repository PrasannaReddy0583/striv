import 'package:equatable/equatable.dart';
import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/auth/domain/entities/auth_tokens.dart';
import 'package:striv/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase implements UseCase<AuthTokens, LoginParams> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<AuthTokens> call(LoginParams params) {
    return repository.login(params.email, params.password);
  }
}

class LoginParams extends Equatable {
  final String email;
  final String password;

  const LoginParams({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
