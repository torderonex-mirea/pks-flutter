import 'package:flutter/material.dart';
import 'package:myapp/components/product_card.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/pages/add_product_page.dart';
import 'package:myapp/pages/cart_page.dart';
import 'package:myapp/pages/profile_page.dart';
import 'package:myapp/pages/favorite_page.dart';

import '../components/navbar.dart';
import '../http/api.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User user = User(
    avatarUrl: 'https://avatars.dzeninfra.ru/get-zen_doc/271828/pub_66689107bdac467014431b33_6668913eac50e73eec9e81ab/scale_1200',
    email: 'egor@sukhanov.com',
    fullName: 'Суханов Егор Александрович',
    phoneNumber: '8 (800)-555-35-35',
  );
  late Future<List<Product>> _productsFuture;
  List<Product> products = [];

  @override
  void initState() {
    super.initState();
    _productsFuture = ApiService().getProducts();
    _productsFuture.then((p) {
      setState(() {
        products = p;
      });
    });
  }
  void _removeProduct(Product product) {
    setState(() {
      products.remove(product);
    });
  }


  int _currentIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  List<Product> get favoriteProducts => products.where((product) => product.isFavorite).toList();
  List<Product> get cart => products.where((product) => product.isInCart).toList();

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      _buildHomePage(),
      FavoritePage(
        products: favoriteProducts,
        onProductRemove: (context){_removeProduct(context);},
      ),
      CartPage(cartProducts: cart),
      ProfilePage(user: user),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Navbar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все товары'),
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
              _removeProduct(products[index]);
            },
            // onFavoriteToggle: () {
            //   setState(() {
            //     _products[index].isFavorite = !_products[index].isFavorite;
            //   });
            // },
          );
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
        backgroundColor: Colors.grey,
        child: const Icon(Icons.add),
      ),
    );
  }
}
