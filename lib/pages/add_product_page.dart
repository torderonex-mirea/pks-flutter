import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';

class AddProductPage extends StatefulWidget {
  final Function(Product) onItemAdded;

  const AddProductPage({super.key, required this.onItemAdded});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();

  String? _description;
  int? _quantity;
  String? _category;
  String? _title;
  int? _price;
  String? _imageUrl;

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final newProduct = Product(
        0,
        _description!,
        _quantity!,
        _category!,
        _title!,
        _price!,
        _imageUrl!,
      );

      widget.onItemAdded(newProduct);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавить продукт'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: const InputDecoration(labelText: 'Описание'),
                onSaved: (value) {
                  _description = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите описание';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Количество'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _quantity = int.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите количество';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Категория'),
                onSaved: (value) {
                  _category = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите категорию';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Название'),
                onSaved: (value) {
                  _title = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите название';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Цена'),
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _price = int.tryParse(value!);
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите цену';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'URL изображения'),
                onSaved: (value) {
                  _imageUrl = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите URL изображения';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: const Text('Добавить продукт'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}