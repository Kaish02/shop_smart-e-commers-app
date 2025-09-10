class ProductModel {
  List<ProductDetailsModel>? products;

  ProductModel({this.products});

  static ProductModel fromJsonToModel(Map<String, dynamic> json) {
    return ProductModel(
      products: json['products']
          .map<ProductDetailsModel>(
              (product) => ProductDetailsModel.fromJson(product))
          .toList(),
    );
  }
}

class ProductDetailsModel {
  int? id;
  String? title;
  String? description;
  dynamic price;
  String? category;
  dynamic discountPercentage;
  dynamic rating;
  String? thumbnail;
  String? brand;

  ProductDetailsModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.category,
    this.discountPercentage,
    this.rating,
    this.thumbnail,
    this.brand,
  });

  static ProductDetailsModel fromJson(Map<String, dynamic> json) {
    return ProductDetailsModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      category: json['category'],
      discountPercentage: json['discountPercentage'],
      rating: json['rating'],
      thumbnail: json['thumbnail'],
      brand: json['brand'],
    );
  }
}
