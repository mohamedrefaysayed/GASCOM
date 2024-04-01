class LoginModel {
  bool? exists;
  String? otp;

  LoginModel({
    this.exists,
    this.otp,
  });

  LoginModel.fromJson(Map<String, dynamic> json) {
    exists = json['exists'];
    otp = json['otp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exists'] = exists;
    data['otp'] = otp;
    return data;
  }
}
