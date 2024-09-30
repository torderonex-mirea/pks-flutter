import 'package:flutter/material.dart';
import 'package:myapp/components/product_card.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/pages/add_product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<Product> products = [
    Product(1, 'Очень хороший телефон', 10, 'Телефоны', 'IPHONE 15 PRO MAX 1TB', 1000, 'https://img.mvideo.ru/Big/30074465bb.jpg'),
    Product(2, 'Очень плохой телефон', 1, 'Телефоны', 'SAMSUNG S11 PRO 512GB', 600, 'https://img.mvideo.ru/Big/30070136bb.jpg'),
    Product(3, 'Телевизор Philips 50PUS8507/60 — модель диагональю 50 дюймов разрешением 3840x2160 пикселей. Частота обновления экрана — 60 Гц. Процессор P5 Perfect Picture обеспечивает обработку картинки, поддерживаются технологии улучшения Dolby Vision, HDR10+', 100, 'Телевизоры', 'Телевизор Philips 50PUS8507/60', 2100, 'https://img.mvideo.ru/Big/10031891bb.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все товары'),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (BuildContext context, int index) {
          return ProductCard(product: products[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(onItemAdded: (newItem) {
                setState(() {
                  newItem.id = products.length + 1;
                  products.add(newItem);
                });
              }),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.grey,
      ),
    );
  }
}
