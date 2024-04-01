class ProfileModel {
  Customer? customer;

  ProfileModel({this.customer});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    customer = json['Customer'] != null
        ? Customer.fromJson(json['Customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (customer != null) {
      data['Customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  String? name;
  String? location;
  String? government;
  String? city;
  String? mobNo;
  String? otp;
  String? noOrders;
  String? totalOrders;
  String? fcm;
  String? token;
  String? isVerified;
  String? createdAt;
  String? updatedAt;

  Customer(
      {this.name,
      this.location,
      this.government,
      this.city,
      this.mobNo,
      this.otp,
      this.noOrders,
      this.totalOrders,
      this.fcm,
      this.token,
      this.isVerified,
      this.createdAt,
      this.updatedAt});

  Customer.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    location = json['location'];
    government = json['government'];
    city = json['city'];
    mobNo = json['mob_no'];
    otp = json['otp'];
    noOrders = json['no_orders'];
    totalOrders = json['total_orders'];
    fcm = json['fcm'];
    token = json['token'];
    isVerified = json['is_verified'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['location'] = location;
    data['government'] = government;
    data['city'] = city;
    data['mob_no'] = mobNo;
    data['otp'] = otp;
    data['no_orders'] = noOrders;
    data['total_orders'] = totalOrders;
    data['fcm'] = fcm;
    data['token'] = token;
    data['is_verified'] = isVerified;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
