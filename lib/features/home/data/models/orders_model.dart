class OrdersModel {
  List<GascomOrder>? orders;

  OrdersModel({this.orders});

  OrdersModel.fromJson(Map<String, dynamic> json) {
    if (json['orders'] != null) {
      orders = <GascomOrder>[];
      json['orders'].forEach((v) {
        orders!.add(GascomOrder.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (orders != null) {
      data['orders'] = orders!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GascomOrder {
  int? id;
  String? status;
  String? noDisks;
  String? totalPrice;
  String? location;
  String? customerMobNo;
  String? agentMobNo;
  String? agentName;
  String? customerName;
  String? createdAt;
  String? updatedAt;
  int? price;

  GascomOrder({
    this.id,
    this.status,
    this.noDisks,
    this.totalPrice,
    this.location,
    this.customerMobNo,
    this.agentMobNo,
    this.agentName,
    this.customerName,
    this.createdAt,
    this.updatedAt,
    this.price,
  });

  GascomOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    noDisks = json['no_disks'];
    totalPrice = json['total_price'];
    location = json['location'];
    customerMobNo = json['customer_mob_no'];
    agentMobNo = json['agent_mob_no'];
    agentName = json['agent_name'];
    customerName = json['customer_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    price = int.parse(json['total_price']) ~/ int.parse(json['no_disks']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['status'] = status;
    data['no_disks'] = noDisks;
    data['total_price'] = totalPrice;
    data['location'] = location;
    data['customer_mob_no'] = customerMobNo;
    data['agent_mob_no'] = agentMobNo;
    data['agent_name'] = agentName;
    data['customer_name'] = customerName;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
