class RegisterModel {
  bool? created;
  String? token;

  RegisterModel({this.created, this.token});

  RegisterModel.fromJson(Map<String, dynamic> json) {
    created = json['created'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['created'] = created;
    data['token'] = token;
    return data;
  }
}
