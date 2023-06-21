import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/login_model.dart';

class LoginService {
  static const _baseUrl = 'http://192.168.1.9:4400';

  Future<LoginResponseModel> login(LoginRequestModel requestModel) async {
    final url = Uri.parse('$_baseUrl/api/auth/login');

    try {
      final response = await http.post(
        url,
        body: requestModel.toJson(),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return LoginResponseModel.fromJson(responseData);
      } else {
        print(json.decode(response.body));
        throw Exception('Failed to login');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server');
    }
  }
}
