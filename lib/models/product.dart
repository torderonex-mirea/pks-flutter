class Product {
  final int id;
  final String title;
  final String time;
  final int price;
  bool isInCart;

  Product(this.id, this.title, this.time, this.price, {this.isInCart = false});
}
