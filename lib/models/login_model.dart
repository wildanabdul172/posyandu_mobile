class LoginResponseModel {
  final int? userId;
  final String? name;
  final String? email;
  final String? phoneNumber;

  LoginResponseModel({
    this.userId,
    this.name,
    this.email,
    this.phoneNumber,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
    );
  }
}

class LoginRequestModel {
  String? email;
  String? password;

  LoginRequestModel({
    this.email,
    this.password,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {};

    if (email != null && email!.isNotEmpty) {
      map['email'] = email!.trim();
    }

    if (password != null && password!.isNotEmpty) {
      map['password'] = password!.trim();
    }

    return map;
  }
}
