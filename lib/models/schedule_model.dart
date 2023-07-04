import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Schedule {
  int? activityId;
  String? activityName;
  String? activityDate;
  String? activityTime;
  int? activityLocation;
  PosyanduSchedule? posyandu;

  Schedule({
    this.activityId,
    this.activityName,
    this.activityDate,
    this.activityTime,
    this.activityLocation,
    this.posyandu,
  });

  Schedule.fromJson(Map<String, dynamic> json) {
    activityId = json['activity_id'];
    activityName = json['activity_name'];
    initializeDateFormatting('id_ID');
    activityDate = _formatDate(json['activity_date']);
    activityTime = _formatTime(json['activity_time']);
    activityLocation = json['activity_location'];
    posyandu = PosyanduSchedule.fromJson(json['posyandu']);
  }
  String _formatDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime localDateTime = dateTime.toLocal();
    String formattedDate =
        DateFormat('EEEE, dd MMMM yyyy', 'id_ID').format(localDateTime);
    return formattedDate;
  }

  String _formatTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    DateTime localDateTime = dateTime.toLocal();
    String formattedTime = DateFormat('kk:mm', 'id_ID').format(localDateTime);
    return formattedTime;
  }
}

class PosyanduSchedule {
  final String name;
  final int id;

  PosyanduSchedule({required this.name, required this.id});

  factory PosyanduSchedule.fromJson(Map<String, dynamic> json) {
    return PosyanduSchedule(
      name: json['posyandu_name'],
      id: json['posyandu_id'],
    );
  }
}
