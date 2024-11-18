import 'package:flutter/material.dart';
import 'package:myapp/http/api.dart';
import 'package:myapp/models/product.dart';

class EditProductPage extends StatefulWidget {
  final int productId;

  const EditProductPage({super.key, required this.productId});

  @override
  _EditProductPageState createState() => _EditProductPageState();
}

class _EditProductPageState extends State<EditProductPage> {
  late Product _product;
  bool _isLoading = true;
  String _errorMessage = '';
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchProductDetails();
  }

  Future<void> _fetchProductDetails() async {
    try {
      Product product = await ApiService().getProductById(widget.productId);
      setState(() {
        _product = product;
        _isLoading = false;

        _titleController.text = product.title;
        _descriptionController.text = product.description;
        _categoryController.text = product.category;
        _priceController.text = product.price.toString();
        _quantityController.text = product.quantity.toString();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Ошибка при загрузке данных о продукте: $e';
      });
    }
  }

  Future<void> _updateProduct() async {
    if (_formKey.currentState?.validate() ?? false) {
      final updatedProduct = Product(
        id: _product.id,
        title: _titleController.text,
        description: _descriptionController.text,
        category: _categoryController.text,
        price: int.parse(_priceController.text),
        quantity: int.parse(_quantityController.text),
        imageUrl: _product.imageUrl,
      );

      try {
        await ApiService().updateProductById(updatedProduct.id,updatedProduct);
        Navigator.pop(context, updatedProduct);
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка при обновлении продукта: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isLoading ? Text('Загрузка...') : Text('Редактирование товара'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage))
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(labelText: 'Название'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите название товара';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Описание'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите описание товара';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _categoryController,
                  decoration: InputDecoration(labelText: 'Категория'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите категорию товара';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Цена'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите цену товара';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Введите правильную цену';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  decoration: InputDecoration(labelText: 'Количество'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Пожалуйста, введите количество товара';
                    }
                    if (int.tryParse(value) == null) {
                      return 'Введите правильное количество';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _updateProduct,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Сохранить изменения',
                      style: TextStyle(fontSize: 18, color: Colors.white),

                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
