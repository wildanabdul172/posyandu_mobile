import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:posyandu/models/queue_model.dart';
import 'package:posyandu/models/register_model.dart';

class RegisterService {
  static const String _baseUrl = 'https://barrxyz.com';
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

  static Future<bool> registerQueue(QueueRequest registerData) async {
    final url = Uri.parse('$_baseUrl/api/master-data/queue');

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

      if (errorMessage == 'Anak sudah terdaftar') {
        RegisterService.lastStatusCode = 400;
      } else {
        RegisterService.lastStatusCode = response.statusCode;
      }

      return false;
    }
  }
}
