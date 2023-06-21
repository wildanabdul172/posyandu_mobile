import 'package:intl/intl.dart';

class Article {
  String? title;
  String? content;
  String? createAt;
  String? image;

  Article({
    this.title,
    this.content,
    this.createAt,
    this.image,
  });

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    content = json['content'];
    createAt = DateFormat('yyyy-MM-dd kk:mm')
        .format(DateTime.parse(json['create_at']));
    image = json['image'];
  }
}
