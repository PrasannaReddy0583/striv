import 'package:dio/dio.dart';
import 'package:striv/core/errors/exceptions.dart';
import 'package:striv/features/auth/data/models/auth_tokens_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthTokensModel> login(String email, String password);
  Future<void> signup(String username, String email, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthTokensModel> login(String email, String password) async {
    try {
      final response = await dio.post(
        '/auth/login',
        data: {'email': email, 'password': password},
      );
      return AuthTokensModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final message = (e.response?.data as Map<String, dynamic>?)?['error']
              as String? ??
          'Login failed';
      throw ServerException(message);
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }

  @override
  Future<void> signup(String username, String email, String password) async {
    try {
      await dio.post(
        '/auth/signup',
        data: {
          'name': username,
          'email': email,
          'password': password,
          'role': 'INVESTOR',
        },
      );
    } on DioException catch (e) {
      final message = (e.response?.data as Map<String, dynamic>?)?['error']
              as String? ??
          'Signup failed';
      throw ServerException(message);
    } catch (e) {
      throw NetworkException('Network error: $e');
    }
  }
}
