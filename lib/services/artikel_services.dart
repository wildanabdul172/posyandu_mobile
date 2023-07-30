import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/artikel_model.dart';

class ArtikelService {
  static const _baseUrl = 'https://barrxyz.com';

  static Future<List<Article>> fetchArtikel() async {
    final response = await http.get(
      Uri.parse('$_baseUrl/api/master-data/articles'),
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Article> articles =
          jsonResponse.map((item) => Article.fromJson(item)).toList();

      // Mengurutkan artikel berdasarkan id terbaru
      articles.sort((a, b) => b.id!.compareTo(a.id!));

      return articles;
    } else {
      throw Exception('Failed to fetch artikel');
    }
  }
}
