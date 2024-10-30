import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String baseUrl = 'http://10.0.2.2:8000';

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/user/login'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': email,
          'password_hash': password,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userId = data["user_id"];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt("user_id", userId);

        return true;
      } else {
        print('Error en login: ${response.body}'); // Mostrar mensaje de error
        return false;
      }
    } catch (e) {
      print('Error en login: $e');
      return false;
    }
  }

  static Future<int?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt("user_id");
  }

  static Future<bool> register({
    required String nombre,
    required String apellido,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/user/insert'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'nombre': nombre,
          'apellido': apellido,
          'email': email,
          'password_hash': password,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        print(
            'Error en registro: ${response.body}'); // Mostrar mensaje de error
        return false;
      }
    } catch (e) {
      print('Error en registro: $e');
      return false;
    }
  }
}
