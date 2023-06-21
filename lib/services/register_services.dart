import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:posyandu/models/register_model.dart';

class RegisterService {
  static const String _baseUrl = 'http://192.168.1.9:4400';
  static int? lastStatusCode;

  static Future<bool> register(Register registerData) async {
    final url = Uri.parse('$_baseUrl/api/auth/register');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(registerData.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      final responseBody = jsonDecode(response.body);
      final errorMessage = responseBody['message'] ?? 'Registrasi gagal';

      if (errorMessage == 'Email sudah terdaftar') {
        RegisterService.lastStatusCode = 400;
      } else {
        RegisterService.lastStatusCode = response.statusCode;
      }

      return false;
    }
  }
}