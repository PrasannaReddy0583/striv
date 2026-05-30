import 'package:striv/core/errors/exceptions.dart';
import 'package:striv/core/errors/failures.dart';
import 'package:striv/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:striv/features/auth/domain/entities/auth_tokens.dart';
import 'package:striv/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<AuthTokens> login(String email, String password) async {
    try {
      return await remoteDataSource.login(email, password);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    }
  }

  @override
  Future<void> signup(String username, String email, String password) async {
    try {
      await remoteDataSource.signup(username, email, password);
    } on ServerException catch (e) {
      throw ServerFailure(e.message);
    } on NetworkException catch (e) {
      throw NetworkFailure(e.message);
    }
  }
}
