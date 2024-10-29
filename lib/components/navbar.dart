import 'package:flutter/material.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const Navbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        iconSize: 32,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/navhome.png"),
            ),
            label: 'Главная',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/Cart.png"),
            ),
            label: 'Корзина',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/icons/user.png"),
            ),
            label: 'Профиль',
          ),
        ],
        currentIndex: currentIndex,
        onTap: onTap,
      ),
    );
  }
}
