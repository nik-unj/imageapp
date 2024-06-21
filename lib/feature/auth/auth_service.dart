import 'package:flutter/material.dart';
import 'package:imageapp/feature/auth/login_screen.dart';
import 'package:imageapp/feature/home/home_screen.dart';

class AuthService extends StatefulWidget {
  const AuthService({super.key});

  @override
  State<AuthService> createState() => _AuthServiceState();
}

class _AuthServiceState extends State<AuthService> {
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoggedIn ? const HomeScreen() : const LoginScreen(),
    );
  }
}
