class AdsModel {
  List<Ads>? ads;

  AdsModel({this.ads});

  AdsModel.fromJson(Map<String, dynamic> json) {
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads!.add(Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ads != null) {
      data['ads'] = ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ads {
  int? id;
  String? name;
  String? paths;
  String? text;
  String? createdAt;
  String? updatedAt;

  Ads(
      {this.id,
      this.name,
      this.paths,
      this.text,
      this.createdAt,
      this.updatedAt});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    paths = json['paths'];
    text = json['text'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['paths'] = paths;
    data['text'] = text;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
