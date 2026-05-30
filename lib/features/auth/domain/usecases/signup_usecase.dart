import 'package:equatable/equatable.dart';
import 'package:striv/core/usecases/usecase.dart';
import 'package:striv/features/auth/domain/repositories/auth_repository.dart';

class SignupUseCase implements UseCase<void, SignupParams> {
  final AuthRepository repository;

  SignupUseCase(this.repository);

  @override
  Future<void> call(SignupParams params) {
    return repository.signup(params.username, params.email, params.password);
  }
}

class SignupParams extends Equatable {
  final String username;
  final String email;
  final String password;

  const SignupParams({
    required this.username,
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [username, email, password];
}
