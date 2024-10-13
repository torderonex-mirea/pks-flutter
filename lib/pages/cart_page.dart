import 'package:flutter/material.dart';
import 'package:myapp/components/cart_item.dart';
import '../models/product.dart';

class CartPage extends StatefulWidget {
  final List<Product> cartProducts;

  const CartPage({super.key, required this.cartProducts});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<Product, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    _quantities = {for (var product in widget.cartProducts) product: 1};
  }

  void _updateQuantity(Product product, int newQuantity) {
    setState(() {
      _quantities[product] = newQuantity;
    });
  }

  double get _totalPrice {
    double total = 0.0;
    _quantities.forEach((product, quantity) {
      total += product.price * quantity;
    });
    return total;
  }

  void _removeProduct(Product product) {
    setState(() {
      widget.cartProducts.remove(product);
      _quantities.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Корзина'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: widget.cartProducts.length,
              itemBuilder: (context, index) {
                final product = widget.cartProducts[index];
                return CartItem(
                  product: product,
                  initialQuantity: _quantities[product] ?? 1,
                  onQuantityChanged: (newQuantity) {
                    _updateQuantity(product, newQuantity);
                  },
                  onRemove: () {
                    _removeProduct(product);
                  },
                );
              },
            ),
          ),
          const Divider(height: 1, color: Colors.black),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Общая сумма: \$${_totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                    },
                    child: const Text('Купить'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
