class SingleProductModel {
  int? id;
  String? title;
  String? description;
  dynamic price;
  String? category;
  dynamic discountPercentage;
  dynamic rating;
  String? thumbnail;
  String? brand;

  SingleProductModel({
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

  factory SingleProductModel.fromJson(Map<String, dynamic> json) {
    return SingleProductModel(
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
