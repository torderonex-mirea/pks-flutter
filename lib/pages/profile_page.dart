import 'package:flutter/material.dart';
import '../models/user.dart';
import 'edit_profile_page.dart';

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
      appBar: AppBar(
        title: const Text('Профиль'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final updatedUser = await Navigator.push<User>(
                context,
                MaterialPageRoute(
                  builder: (context) => EditProfilePage(user: _user),
                ),
              );

              if (updatedUser != null) {
                _updateUser(updatedUser);
              }
            },
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(_user.avatarUrl),
            ),
            const SizedBox(height: 20),
            Text(
              _user.fullName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _user.email,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              _user.phoneNumber,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  final updatedUser = await Navigator.push<User>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditProfilePage(user: _user),
                    ),
                  );

                  if (updatedUser != null) {
                    _updateUser(updatedUser);
                  }
                },
                child: const Text(
                  'Редактировать профиль',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
