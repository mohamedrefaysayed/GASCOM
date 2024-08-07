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
  int? distance;
  String? price;

  Agents({this.mobNo, this.name, this.distance});

  Agents.fromJson(Map<String, dynamic> json) {
    mobNo = json['mob_no'] as String?;
    name = json['name'] as String?;
    distance = json['distance'] as int?;
    price = json['price'] as String?;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mob_no'] = mobNo;
    data['name'] = name;
    data['distance'] = distance;
    data['price'] = price;
    return data;
  }
}
