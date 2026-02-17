import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = 'http://localhost:3000/api/auth';

  Future<bool> signup(String username, String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/signup'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': username,
          'email': email,
          'password': password,
          'role': 'INVESTOR',
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Signup failed');
      }
    } catch (e) {
      throw Exception('Signup error: $e');
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Extract token + user info
        final idToken = data['idToken'];
        final accessToken = data['accessToken'];
        final refreshToken = data['refreshToken'];

        // if (idToken == null) throw Exception("No idToken in response");

        // TODO: store token securely (SharedPreferences, flutter_secure_storage)
        return {
          'idToken': idToken,
          'accessToken': accessToken,
          'refreshToken': refreshToken,
        };
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['error'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Login error: $e');
    }
  }
}
