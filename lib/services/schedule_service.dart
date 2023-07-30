import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/schedule_model.dart';

class ScheduleService {
  static const _baseUrl = 'https://barrxyz.com';

  static Future<List<Schedule>> fetchSchedule() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/master-data/activities'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Schedule> activities =
          jsonResponse.map((item) => Schedule.fromJson(item)).toList();
      return activities;
    } else {
      throw Exception('Failed to fetch artikel');
    }
  }
}
