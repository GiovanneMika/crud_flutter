class ProductModel {
  String? id;
  String? name;
  String? description;
  double? price;
  int? stock;
  bool? isAvailable;
  String? category;
  String? imageUrl;
  List<String>? tags;
  String? updatedAt;

  ProductModel({
    this.id,
    this.name,
    this.description,
    this.price,
    this.stock,
    this.isAvailable,
    this.category,
    this.imageUrl,
    this.tags,
    this.updatedAt,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = (json['price'] as num?)?.toDouble();
    stock = json['stock'];
    isAvailable = json['isAvailable'];
    category = json['category'];
    imageUrl = json['imageUrl'];
    tags = (json['tags'] as List<dynamic>?)?.cast<String>();
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (id != null) {
      data['id'] = id;
    }
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stock'] = stock;
    data['isAvailable'] = isAvailable;
    data['category'] = category;
    data['imageUrl'] = imageUrl;
    data['tags'] = tags;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
