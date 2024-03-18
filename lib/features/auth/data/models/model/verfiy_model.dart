class VerfiyModel {
  bool? verified;
  String? fcm;
  String? mobNo;
  String? token;

  VerfiyModel({this.verified, this.fcm, this.mobNo, this.token});

  VerfiyModel.fromJson(Map<String, dynamic> json) {
    verified = json['verified'];
    fcm = json['fcm'];
    mobNo = json['mob_no'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['verified'] = verified;
    data['fcm'] = fcm;
    data['mob_no'] = mobNo;
    data['token'] = token;
    return data;
  }
}
