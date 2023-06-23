import 'package:intl/intl.dart';

class HistoryChildResponseModel {
  int? childId;
  int? weight;
  int? height;
  String? dateOfRecord;
  int? headCircumference;
  int? armCircumference;
  String? immunization;

  HistoryChildResponseModel({
    this.childId,
    this.weight,
    this.height,
    this.dateOfRecord,
    this.headCircumference,
    this.armCircumference,
    this.immunization,
  });

  HistoryChildResponseModel.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    weight = json['weight'] ?? '-';
    height = json['height'] ?? '-';
    dateOfRecord = DateFormat('dd MMMM yyyy')
        .format(DateTime.parse(json['date_of_record']));
    headCircumference = json['head_circumference'] ?? '-';
    armCircumference = json['arm_circumference'] ?? '-';
    immunization = json['immunization'] ?? '-';
  }
}
