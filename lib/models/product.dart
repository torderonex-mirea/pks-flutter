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
}
