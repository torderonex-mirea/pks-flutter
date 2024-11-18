import 'package:flutter/material.dart';
import 'package:myapp/components/product_card.dart';
import 'package:myapp/models/product.dart';

class FavoritePage extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onProductRemove;

  const FavoritePage({super.key, required this.products, required this.onProductRemove});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            product: products[index],
            onProductRemove: () {
              onProductRemove(products[index]);
            },
          );
        },
      ),
    );
  }
}
