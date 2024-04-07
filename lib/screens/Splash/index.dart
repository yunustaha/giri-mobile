import 'dart:async';
import 'package:flutter/material.dart';
import 'package:giri/widgets/Logo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    final box = Hive.box('auth');
    final token = box.get('token');

    Future.delayed(const Duration(seconds: 2), () {
      if (token != null) {
        // Kullanıcı oturum açmışsa ana sayfaya yönlendir
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Kullanıcı oturum açmamışsa giriş sayfasına yönlendir
        Navigator.of(context).pushReplacementNamed('/signIn');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Align(
            child: Logo(),
          ),
        ),
      ),
    );
  }
}
