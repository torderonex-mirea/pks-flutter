import 'package:flutter/material.dart';
import '../models/product.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class CartItem extends StatefulWidget {
  final Product product;
  final int initialQuantity;
  final Function(int) onQuantityChanged;
  final Function() onRemove;

  const CartItem({
    super.key,
    required this.product,
    this.initialQuantity = 1,
    required this.onQuantityChanged,
    required this.onRemove,
  });

  @override
  _CartItemState createState() => _CartItemState();
}

class _CartItemState extends State<CartItem> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
  }

  void _increaseQuantity() {
    setState(() {
      _quantity++;
    });
    widget.onQuantityChanged(_quantity);
  }

  void _decreaseQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
      widget.onQuantityChanged(_quantity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: Key(widget.product.id.toString()),
      direction: Axis.horizontal,
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.5,
        children: [
          SlidableAction(
            onPressed: (context) {
              widget.onRemove();
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Удалить',
          ),
        ],
      ),
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Image.network(
                widget.product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.product.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '\$${widget.product.price}',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: _decreaseQuantity,
                  ),
                  Text(
                    '$_quantity',
                    style: const TextStyle(fontSize: 16),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: _increaseQuantity,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
