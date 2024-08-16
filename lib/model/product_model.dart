class Product {
  final String imageUrl;
  final String name;
  final String category;
  final double price;
  final String location;
  final String description;

  Product({
    required this.imageUrl,
    required this.name,
    required this.category,
    required this.price,
    required this.location,
    required this.description,
  });
}

class Products {
  String? sId;
  String? productName;
  int? productPrice;
  String? productDescription;
  String? productCategory;
  String? productLocation;
  String? productImage;
  bool? isApproved;
  String? createAt;
  String? updatedAt;
  int? v;

  Products(
      {this.sId,
      this.productName,
      this.productPrice,
      this.productDescription,
      this.productCategory,
      this.productLocation,
      this.productImage,
      this.isApproved,
      this.createAt,
      this.updatedAt,
      this.v});

  Products.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    productName = json['name'];
    productPrice = json['price'];
    productDescription = json['description'];
    productCategory = json['category'];
    productLocation = json['productLocation'];
    productImage = json['image'];
    isApproved = json['isApproved'];
    createAt = json['createAt'];
    updatedAt = json['updatedAt'];
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = productName;
    data['price'] = productPrice;
    data['description'] = productDescription;
    data['category'] = productCategory;
    data['productLocation'] = productLocation;
    data['image'] = productImage;
    data['isApproved'] = isApproved;
    data['createAt'] = createAt;
    data['updatedAt'] = updatedAt;
    data['v'] = v;
    return data;
  }
}
