import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:posyandu/models/children_model.dart';

class ChildrenService {
  static const String _baseUrl = 'http://192.168.1.9:4400';
  static int? lastStatusCode;

  static Future<bool> register(ChildrenRequestModel registerData) async {
    final url = Uri.parse('$_baseUrl/api/master-data/children');

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
        ChildrenService.lastStatusCode = 400;
      } else {
        ChildrenService.lastStatusCode = response.statusCode;
      }

      return false;
    }
  }

  static Future<List<ChildrenResponseModel>> fetchChildren(String id) async {
    final url = Uri.parse('$_baseUrl/api/master-data/users/4/children');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);

      List<ChildrenResponseModel> childrens = jsonResponse
          .map((item) => ChildrenResponseModel.fromJson(item))
          .toList();
      return childrens;
    } else {
      throw Exception('Failed to fetch children data');
    }
  }
}
