class CartItem {
  int? id;
  final String title;
  final String image;
  final double price;
  int quantity;

  CartItem({
    this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'price': price,
      'quantity': quantity,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      title: map['title'],
      image: map['image'],
      price: map['price'],
      quantity: map['quantity'],
    );
  }
}
