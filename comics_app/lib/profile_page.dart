import 'package:flutter/material.dart';
import 'auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService authService = AuthService();
  Map<String, dynamic>? userProfile;
  String? userEmail;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    final user = await authService.getCurrentUser();
    if (user != null) {
      final profile = await authService.getUserProfile(user.id);
      setState(() {
        userProfile = profile;
        userEmail = user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Container(
        color: Colors.white, // Устанавливаем белый фон
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (userProfile != null)
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(userProfile!['avatar_url']),
                ),
              const SizedBox(height: 20),
              if (userProfile != null)
                Text(
                  userProfile!['full_name'],
                  style: const TextStyle(fontSize: 24),
                ),
              const SizedBox(height: 10),
              if (userEmail != null)
                Text(
                  userEmail!,
                  style: const TextStyle(fontSize: 18),
                ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  await authService.signOut();
                  Navigator.of(context).pushReplacementNamed('/login');
                },
                child: const Text('Выйти'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}