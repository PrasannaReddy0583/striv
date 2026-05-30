import 'package:striv/features/auth/domain/entities/auth_tokens.dart';

class AuthTokensModel extends AuthTokens {
  const AuthTokensModel({
    super.idToken,
    super.accessToken,
    super.refreshToken,
  });

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) {
    return AuthTokensModel(
      idToken: json['idToken'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'idToken': idToken,
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
