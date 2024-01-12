class SubCategoryProductsModel {
  MainCategory? category;
  List<Products>? products;

  SubCategoryProductsModel({this.category, this.products});

  SubCategoryProductsModel.fromJson(Map<String, dynamic> json) {
    category = json['category'] != null
        ? MainCategory.fromJson(json['category'])
        : null;
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  int? id;
  String? categoryName;
  String? description;
  String? image;
  String? level;
  String? parentId;
  String? categorySpecificationId;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  CategorySpecification? categorySpecification;

  Category(
      {this.id,
      this.categoryName,
      this.description,
      this.image,
      this.level,
      this.parentId,
      this.categorySpecificationId,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.categorySpecification});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    description = json['description'];
    image = json['image'];
    level = json['level'];
    parentId = json['parent_id'];
    categorySpecificationId = json['category_specification_id'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    categorySpecification = json['category_specification'] != null
        ? CategorySpecification.fromJson(json['category_specification'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['image'] = image;
    data['level'] = level;
    data['parent_id'] = parentId;
    data['category_specification_id'] = categorySpecificationId;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (categorySpecification != null) {
      data['category_specification'] = categorySpecification!.toJson();
    }
    return data;
  }
}

class CategorySpecification {
  int? id;
  String? specificationName;
  String? description;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  CategorySpecification(
      {this.id,
      this.specificationName,
      this.description,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  CategorySpecification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    specificationName = json['specification_name'];
    description = json['description'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['specification_name'] = specificationName;
    data['description'] = description;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Products {
  int? id;
  String? productName;
  String? description;
  String? image;
  String? wholeSalePrice;
  String? retailPrice;
  String? vipPrice;
  String? categoryId;
  String? companyId;
  String? unitGroupId;
  String? wholeUnitId;
  String? retailUnitId;
  String? vipUnitId;
  String? discount;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  String? minWholeQuantity;
  String? minRetailQuantity;
  String? minVipQuantity;
  String? maxWholeQuantity;
  String? maxRetailQuantity;
  WholeUnit? wholeUnit;
  UnitGroup? unitGroup;
  MainCategory? category;
  Company? company;
  WholeUnit? retailUnit;
  WholeUnit? vipUnit;

  Products(
      {this.id,
      this.productName,
      this.description,
      this.image,
      this.wholeSalePrice,
      this.retailPrice,
      this.vipPrice,
      this.categoryId,
      this.companyId,
      this.unitGroupId,
      this.wholeUnitId,
      this.retailUnitId,
      this.vipUnitId,
      this.discount,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt,
      this.minWholeQuantity,
      this.minRetailQuantity,
      this.minVipQuantity,
      this.maxWholeQuantity,
      this.maxRetailQuantity,
      this.wholeUnit,
      this.unitGroup,
      this.category,
      this.company,
      this.retailUnit,
      this.vipUnit});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    description = json['description'];
    image = json['image'];
    wholeSalePrice = json['whole_sale_price'];
    retailPrice = json['retail_price'];
    vipPrice = json['vip_price'];
    categoryId = json['category_id'];
    companyId = json['company_id'];
    unitGroupId = json['unit_group_id'];
    wholeUnitId = json['whole_unit_id'];
    retailUnitId = json['retail_unit_id'];
    vipUnitId = json['vip_unit_id'];
    discount = json['discount'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    minWholeQuantity = json['min_whole_quantity'];
    minRetailQuantity = json['min_retail_quantity'];
    minVipQuantity = json['min_vip_quantity'];
    maxWholeQuantity = json['max_whole_quantity'];
    maxRetailQuantity = json['max_retail_quantity'];
    wholeUnit = json['whole_unit'] != null
        ? WholeUnit.fromJson(json['whole_unit'])
        : null;
    unitGroup = json['unit_group'] != null
        ? UnitGroup.fromJson(json['unit_group'])
        : null;
    category = json['category'] != null
        ? MainCategory.fromJson(json['category'])
        : null;
    company =
        json['company'] != null ? Company.fromJson(json['company']) : null;
    retailUnit = json['retail_unit'] != null
        ? WholeUnit.fromJson(json['retail_unit'])
        : null;
    vipUnit =
        json['vip_unit'] != null ? WholeUnit.fromJson(json['vip_unit']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['product_name'] = productName;
    data['description'] = description;
    data['image'] = image;
    data['whole_sale_price'] = wholeSalePrice;
    data['retail_price'] = retailPrice;
    data['vip_price'] = vipPrice;
    data['category_id'] = categoryId;
    data['company_id'] = companyId;
    data['unit_group_id'] = unitGroupId;
    data['whole_unit_id'] = wholeUnitId;
    data['retail_unit_id'] = retailUnitId;
    data['vip_unit_id'] = vipUnitId;
    data['discount'] = discount;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['min_whole_quantity'] = minWholeQuantity;
    data['min_retail_quantity'] = minRetailQuantity;
    data['min_vip_quantity'] = minVipQuantity;
    data['max_whole_quantity'] = maxWholeQuantity;
    data['max_retail_quantity'] = maxRetailQuantity;
    if (wholeUnit != null) {
      data['whole_unit'] = wholeUnit!.toJson();
    }
    if (unitGroup != null) {
      data['unit_group'] = unitGroup!.toJson();
    }
    if (category != null) {
      data['category'] = category!.toJson();
    }
    if (company != null) {
      data['company'] = company!.toJson();
    }
    if (retailUnit != null) {
      data['retail_unit'] = retailUnit!.toJson();
    }
    if (vipUnit != null) {
      data['vip_unit'] = vipUnit!.toJson();
    }
    return data;
  }
}

class WholeUnit {
  int? id;
  String? unitName;
  String? eq;
  String? unitGroupId;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  WholeUnit(
      {this.id,
      this.unitName,
      this.eq,
      this.unitGroupId,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  WholeUnit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitName = json['unit_name'];
    eq = json['eq'];
    unitGroupId = json['unit_group_id'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit_name'] = unitName;
    data['eq'] = eq;
    data['unit_group_id'] = unitGroupId;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UnitGroup {
  int? id;
  String? unitGroupName;
  String? description;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  UnitGroup(
      {this.id,
      this.unitGroupName,
      this.description,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  UnitGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    unitGroupName = json['unit_group_name'];
    description = json['description'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['unit_group_name'] = unitGroupName;
    data['description'] = description;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class MainCategory {
  int? id;
  String? categoryName;
  String? description;
  String? image;
  String? level;
  String? parentId;
  String? categorySpecificationId;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  MainCategory(
      {this.id,
      this.categoryName,
      this.description,
      this.image,
      this.level,
      this.parentId,
      this.categorySpecificationId,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  MainCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    description = json['description'];
    image = json['image'];
    level = json['level'];
    parentId = json['parent_id'];
    categorySpecificationId = json['category_specification_id'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['category_name'] = categoryName;
    data['description'] = description;
    data['image'] = image;
    data['level'] = level;
    data['parent_id'] = parentId;
    data['category_specification_id'] = categorySpecificationId;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Company {
  int? id;
  String? companyName;
  String? description;
  String? logo;
  String? status;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Company(
      {this.id,
      this.companyName,
      this.description,
      this.logo,
      this.status,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Company.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    companyName = json['company_name'];
    description = json['description'];
    logo = json['logo'];
    status = json['status'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['company_name'] = companyName;
    data['description'] = description;
    data['logo'] = logo;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
