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
    price = json['price'];
    stock = json['stock'];
    isAvailable = json['isAvailable'];
    category = json['category'];
    imageUrl = json['imageUrl'];
    tags = json['tags'].cast<String>();
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['isAvailable'] = this.isAvailable;
    data['category'] = this.category;
    data['imageUrl'] = this.imageUrl;
    data['tags'] = this.tags;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
