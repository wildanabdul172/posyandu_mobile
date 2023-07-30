import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:posyandu/models/history_child_model.dart';

class HistoryChildService {
  static const String _baseUrl = 'https://barrxyz.com';

  static Future<List<HistoryChildResponseModel>> fetchHistory(String id) async {
    final url =
        Uri.parse('$_baseUrl/api/master-data/children/$id/healthRecords');

    final response = await http.get(url);

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<HistoryChildResponseModel> history = jsonResponse
          .map((item) => HistoryChildResponseModel.fromJson(item))
          .toList();
      return history;
    } else {
      throw Exception('Failed to fetch history data');
    }
  }
}
