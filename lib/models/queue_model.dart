import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class QueueResponse {
  final int? queueId;
  final int? childId;
  final int? queueNumber;
  final String? dateOfQueue;
  final String? timeOfQueue;
  final String? status;
  final int? userId;
  final int? posyanduId;
  final Child? child;
  final User? user;
  final Posyandu? posyandu;

  QueueResponse({
    this.queueId,
    this.childId,
    this.queueNumber,
    this.dateOfQueue,
    this.timeOfQueue,
    this.status,
    this.userId,
    this.posyanduId,
    this.child,
    this.user,
    this.posyandu,
  });

  factory QueueResponse.fromJson(Map<String, dynamic> json) {
    initializeDateFormatting('id_ID');

    return QueueResponse(
      queueId: json['queue_id'],
      childId: json['child_id'],
      queueNumber: json['queue_number'],
      dateOfQueue: DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
          .format(DateTime.parse(json['date_of_queue']).toLocal()),
      timeOfQueue: json['time_of_queue'],
      status: json['status'],
      userId: json['user_id'],
      posyanduId: json['posyandu_id'],
      child: Child.fromJson(json['child']),
      user: User.fromJson(json['user']),
      posyandu: Posyandu.fromJson(json['posyandu']),
    );
  }
}

class Child {
  final String name;
  final int childId;

  Child({required this.name, required this.childId});

  factory Child.fromJson(Map<String, dynamic> json) {
    return Child(
      name: json['name'],
      childId: json['child_id'],
    );
  }
}

class User {
  final String name;
  final int userId;

  User({required this.name, required this.userId});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      userId: json['user_id'],
    );
  }
}

class Posyandu {
  final String posyanduName;
  final int posyanduId;

  Posyandu({required this.posyanduName, required this.posyanduId});

  factory Posyandu.fromJson(Map<String, dynamic> json) {
    return Posyandu(
      posyanduName: json['posyandu_name'],
      posyanduId: json['posyandu_id'],
    );
  }
}

class QueueRequest {
  int? childId;
  String? date;
  String? time;
  String? status;
  String? userId;
  int? posyanduId;

  QueueRequest({
    this.childId,
    this.date,
    this.time,
    this.status,
    this.userId,
    this.posyanduId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['child_id'] = childId;
    data['date_of_queue'] = date;
    data['time_of_queue'] = time;
    data['status'] = status;
    data['user_id'] = userId;
    data['posyandu_id'] = posyanduId;
    return data;
  }
}
