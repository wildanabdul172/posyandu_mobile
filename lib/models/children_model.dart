import 'package:intl/intl.dart';

class ChildrenRequestModel {
  String? name;
  String? birtOfDate;
  String? gender;
  String? address;
  String? parentName;
  String? parentPhoneNumber;
  String? userId;

  ChildrenRequestModel({
    this.name,
    this.birtOfDate,
    this.gender,
    this.address,
    this.parentName,
    this.parentPhoneNumber,
    this.userId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['date_of_birth'] = birtOfDate;
    data['gender'] = gender;
    data['address'] = address;
    data['parent_name'] = parentName;
    data['parent_phone_number'] = parentPhoneNumber;
    data['user_id'] = userId;
    return data;
  }
}

class ChildrenResponseModel {
  int? childId;
  String? name;
  String? birtOfDate;
  String? gender;
  String? address;
  String? parentName;
  String? parentPhoneNumber;
  String? userId;

  ChildrenResponseModel({
    this.childId,
    this.name,
    this.birtOfDate,
    this.gender,
    this.address,
    this.parentName,
    this.parentPhoneNumber,
    this.userId,
  });

  ChildrenResponseModel.fromJson(Map<String, dynamic> json) {
    childId = json['child_id'];
    name = json['name'];
    gender = json['gender'];
    birtOfDate = DateFormat('yyyy-MM-dd kk:mm')
        .format(DateTime.parse(json['date_of_birth']));
    address = json['address'];
    parentName = json['parent_name'];
    parentPhoneNumber = json['parent_phone_number'];
  }
}
