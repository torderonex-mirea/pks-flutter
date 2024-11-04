class Product {
  int id;
  String description;
  int quantity;
  String category;
  String title;
  int price;
  String imageUrl;
  bool isFavorite;
  bool isInCart;

  Product({
    required this.id,
    required this.description,
    required this.quantity,
    required this.category,
    required this.title,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
    this.isInCart = false,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['ID'],
      title: json['Name'],
      description: json['Description'],
      price: json['Price'].toInt(),
      imageUrl: json['ImageURL'],
      quantity: 145,
      category: 'Ноутбуки',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Name': title,
      'Description': description,
      'Price': price,
      'ImageURL': imageUrl,
    };
  }

}