import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_tasker/screens/UI/dashboardScreen.dart';
import 'package:pro_tasker/screens/auth_page/authentication_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateUser();
  }

  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 1));

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboardscreen(userId: user.uid),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthenticationPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo2.png", width: 300),



          ],
        ),
      ),
    );
  }
}
