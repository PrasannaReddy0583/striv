import 'package:equatable/equatable.dart';

class AuthTokens extends Equatable {
  final String? idToken;
  final String? accessToken;
  final String? refreshToken;

  const AuthTokens({
    this.idToken,
    this.accessToken,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [idToken, accessToken, refreshToken];
}
