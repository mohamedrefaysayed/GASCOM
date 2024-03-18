class LoginModel {
  bool? exists;
  String? otp;
  String? fcm;
  String? mobNo;

  LoginModel({this.exists, this.otp, this.fcm, this.mobNo});

  LoginModel.fromJson(Map<String, dynamic> json) {
    exists = json['exists'];
    otp = json['otp'];
    fcm = json['fcm'];
    mobNo = json['mob_no'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['exists'] = exists;
    data['otp'] = otp;
    data['fcm'] = fcm;
    data['mob_no'] = mobNo;
    return data;
  }
}
