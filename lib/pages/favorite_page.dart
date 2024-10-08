import 'package:flutter/material.dart';
import 'package:myapp/components/product_card.dart';
import 'package:myapp/models/product.dart';

class FavoritePage extends StatelessWidget {
  final List<Product> products;

  const FavoritePage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Избранное'),
      ),
      backgroundColor: Colors.white,
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 columns
          childAspectRatio: 0.6, // Adjust the aspect ratio for the cards
          crossAxisSpacing: 8, // Space between columns
          mainAxisSpacing: 8, // Space between rows
        ),
        padding: const EdgeInsets.all(8.0),
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(
            product: products[index],
            // onFavoriteToggle: () {
            //   setState(() {
            //     products[index].isFavorite = !products[index].isFavorite;
            //   });
            // },
          );
        },
      ),
    );
  }
}
