import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/queue_model.dart';

class QueueService {
  static const _baseUrl = 'http://192.168.1.9:4400';

  static Future<QueueResponse> getQueueData(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/master-data/posyandu/$id/queue'),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      QueueResponse queue = QueueResponse.fromJson(jsonResponse);
      return queue;
    } else {
      throw Exception('Failed to fetch artikel');
    }
  }

  static Future<List<QueueResponse>> fetchQueueByUserId(String id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/master-data/users/$id/queue'),
    );

    if (response.statusCode == 200) {
      dynamic jsonResponse = jsonDecode(response.body);

      if (jsonResponse is List) {
        List<QueueResponse> queue = jsonResponse
            .map((item) => QueueResponse.fromJson(item as Map<String, dynamic>))
            .toList();
        return queue;
      } else if (jsonResponse is Map<String, dynamic>) {
        QueueResponse singleQueue = QueueResponse.fromJson(jsonResponse);
        return [singleQueue];
      } else {
        throw Exception('Invalid JSON response');
      }
    } else {
      throw Exception('Failed to fetch queue by user id');
    }
  }
}
