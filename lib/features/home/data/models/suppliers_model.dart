class SuppliersModel {
  List<Agents>? agents;

  SuppliersModel({this.agents});

  SuppliersModel.fromJson(Map<String, dynamic> json) {
    if (json['agents'] != null) {
      agents = <Agents>[];
      json['agents'].forEach((v) {
        agents!.add(Agents.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (agents != null) {
      data['agents'] = agents!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Agents {
  String? mobNo;
  String? name;
  double? distanceKm;
  String? price;

  Agents({this.mobNo, this.name, this.distanceKm});

  Agents.fromJson(Map<String, dynamic> json) {
    mobNo = json['mob_no'];
    name = json['name'];
    distanceKm = json['distance_km'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mob_no'] = mobNo;
    data['name'] = name;
    data['distance_km'] = distanceKm;
    data['price'] = price;
    return data;
  }
}
