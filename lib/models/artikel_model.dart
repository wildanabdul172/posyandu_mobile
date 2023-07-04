import 'package:intl/intl.dart';

class Article {
  int? id;
  String? title;
  String? content;
  String? createAt;
  String? image;

  Article({
    this.id,
    this.title,
    this.content,
    this.createAt,
    this.image,
  });

  Article.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createAt = _formatDateTime(json['create_at']);
    image = json['image'];
  }

  String _formatDateTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime localDateTime = dateTime.toLocal();
    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(localDateTime);
    return formattedDate;
  }
}
