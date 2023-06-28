import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/queue_model.dart';

class QueueService {
  static const _baseUrl = 'http://192.168.1.9:4400';

  static Future<List<QueueResponse>> getQueueData() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/master-data/queue'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<QueueResponse> queueList =
          jsonResponse.map((item) => QueueResponse.fromJson(item)).toList();

      List<int> posyanduIds = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
      List<String> queueNumbers = [];

      for (int posyanduId in posyanduIds) {
        QueueResponse queue = queueList.firstWhere(
          (queue) => queue.posyandu?.posyanduId == posyanduId,
          orElse: () => QueueResponse(),
        );

        if (queue != null) {
          queueNumbers.add(queue.queueNumber as String);
        } else {
          queueNumbers.add("Tidak ada antrian");
        }
      }

      print("Nomor Antrian: $queueNumbers");

      return queueList;
    } else {
      throw Exception('Gagal mengambil data antrian');
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
