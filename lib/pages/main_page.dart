import 'package:flutter/material.dart';
import 'package:myapp/components/product_card.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/pages/add_product_page.dart';
import 'package:myapp/pages/profile_page.dart';
import 'package:myapp/pages/favorite_page.dart';

import '../mocks/products.dart';
import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User user = User(
    avatarUrl: 'https://steamuserimages-a.akamaihd.net/ugc/2502382832085360498/508573C25AB27D1D611A2BEC4341E667AB2E1E2F/',
    email: 'egor@sukhanov.com',
    fullName: 'Суханов Егор Александрович',
    phoneNumber: '8 (800)-555-35-35',
  );



  int _currentIndex = 0;

  List<Product> get favoriteProducts => products.where((product) => product.isFavorite).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Все товары'),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FavoritePage(products: favoriteProducts)),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage(user: user)),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Товары',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Избранное',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Профиль',
          ),
        ],
      ),
    );
  }
}
