import 'package:striv/features/auth/domain/entities/auth_tokens.dart';

abstract class AuthRepository {
  Future<AuthTokens> login(String email, String password);
  Future<void> signup(String username, String email, String password);
}
