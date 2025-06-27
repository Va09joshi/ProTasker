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
    // TODO: implement initState
    super.initState();
     _navigateUser();
  }

  void _navigateUser() async {
    await Future.delayed(const Duration(seconds: 2)); // Optional: show splash delay

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // ✅ User already signed in
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboardscreen()),
      );
    } else {
      // 🚪 No user, go to Login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthenticationPage()),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/workorder.png",width: 200,height: 200,),
            Text("Pro Tasker",style: GoogleFonts.getFont("Noto Sans Old Italic",fontSize: 24,fontWeight: FontWeight.bold),)

          ]
          ,
        ),
      ),

    );
  }
}
