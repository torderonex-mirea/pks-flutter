import 'package:flutter/material.dart';
import '../models/user.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({
    super.key,
    required this.user,
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User _user;

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  void _updateUser(User updatedUser) {
    setState(() {
      _user = updatedUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 27.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 48),
              Text(
                _user.fullName,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _user.phoneNumber,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                _user.email,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 40),
              _buildMenuItem(
                iconPath: 'assets/icons/orders.png',
                text: 'Мои заказы',
              ),
              _buildMenuItem(
                iconPath: 'assets/icons/cards.png',
                text: 'Медицинские карты',
              ),
              _buildMenuItem(
                iconPath: 'assets/icons/home.png',
                text: 'Мои адреса',
              ),
              _buildMenuItem(
                iconPath: 'assets/icons/settings.png',
                text: 'Настройки',
              ),
              const SizedBox(height: 60),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Add navigation
                  },
                  child: const Text(
                    'Ответы на вопросы',
                    style: TextStyle(color: Colors.grey,
                        fontSize: 15,
                          fontWeight: FontWeight.w100),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Add navigation
                  },
                  child: const Text(
                    'Политика конфиденциальности',
                    style: TextStyle(color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Add navigation
                  },
                  child: const Text(
                    'Пользовательское соглашение',
                    style: TextStyle(color: Colors.grey,
                        fontSize: 15,
                        fontWeight: FontWeight.w100),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: GestureDetector(
                  onTap: () {
                    // Add logout logic
                  },
                  child: const Text(
                    'Выход',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.red,
                      fontWeight: FontWeight.w100,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuItem({required String iconPath, required String text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        children: [
          Image.asset(
            iconPath,
            width: 32,
            height: 32,
          ),
          const SizedBox(width: 16),
          Text(
            text,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}
