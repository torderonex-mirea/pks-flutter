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
      id: json['id'].toInt(),
      title: json['name'],
      description: json['description'],
      price: json['price'].toInt(),
      imageUrl: json['image_url'],
      quantity: json['quantity'].toInt(),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
      'description': description,
      'price': price,
      'image_url': imageUrl,
      'quantity' : quantity,
      'category' : category,
    };
  }

}