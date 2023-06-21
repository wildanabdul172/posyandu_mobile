class Register {
  String? fullname;
  String? email;
  String? password;
  String? address;
  String? phoneNumber;

  Register({
    this.fullname,
    this.email,
    this.password,
    this.address,
    this.phoneNumber,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = fullname;
    data['email'] = email;
    data['password'] = password;
    data['address'] = address;
    data['phone_number'] = phoneNumber;
    return data;
  }
}
