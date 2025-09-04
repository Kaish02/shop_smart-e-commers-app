class Product {
  final int id;
  final String title;
  final String price;
  final String image;
  final bool isFav;

  Product({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
    this.isFav = true,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      image: map['image'],
      isFav: map['isFav'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
      'isFav': isFav ? 1 : 0,
    };
  }
}
