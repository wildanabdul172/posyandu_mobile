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
    activityDate = DateFormat('EEEE, dd MMMM yyyy', 'id_ID')
        .format(DateTime.parse(json['activity_date']));
    activityTime =
        DateFormat('kk:mm').format(DateTime.parse(json['activity_time']));
    activityLocation = json['activity_location'];
    posyandu = PosyanduSchedule.fromJson(json['posyandu']);
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
