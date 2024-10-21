import 'package:flutter/material.dart';
import 'package:myapp/components/cart_item.dart';
import '../models/product.dart';

class CartPage extends StatefulWidget {
  final List<Product> cart;

  const CartPage({super.key, required this.cart});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Map<Product, int> _quantities = {};

  @override
  void initState() {
    super.initState();
    _quantities = {for (var product in widget.cart) product: 1};
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
      product.isInCart = false;
      widget.cart.remove(product);
      _quantities.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 48,),
            const Text(
              'Корзина',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w500,
              ),
            ),
            Flexible(
              child: ListView.builder(
                itemCount: widget.cart.length,
                itemBuilder: (context, index) {
                  final product = widget.cart[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: CartItem(
                      product: product,
                      initialQuantity: _quantities[product] ?? 1,
                      onQuantityChanged: (newQuantity) {
                        _updateQuantity(product, newQuantity);
                      },
                      onRemove: () {
                        _removeProduct(product);
                      },
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Сумма',
                        style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '$_totalPrice ₽',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: (){},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(26, 111, 238, 1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Перейти к оформлению заказа',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
