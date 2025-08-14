// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:pro_tasker/screens/UI/dashboardScreen.dart';
import '../auth/auth_service.dart';

class LoginScreeno extends StatefulWidget {
  const LoginScreeno({super.key});

  @override
  State<LoginScreeno> createState() => _LoginScreenoState();
}

class _LoginScreenoState extends State<LoginScreeno> {
  final AuthService _auth = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadRememberedUser();
  }

  Future<void> _loadRememberedUser() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      rememberMe = prefs.getBool('rememberMe') ?? false;
      emailController.text = prefs.getString('email') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
    });
  }

  Future<void> _saveCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    if (rememberMe) {
      await prefs.setBool('rememberMe', true);
      await prefs.setString('email', emailController.text);
      await prefs.setString('password', passwordController.text);
    } else {
      await prefs.clear();
    }
  }

  Future<void> _login() async {
    setState(() => isLoading = true);

    final result = await _auth.signIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (result == null) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      await _saveCredentials();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Dashboardscreen(userId: userId)),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
    }

    setState(() => isLoading = false);
  }

  Future<void> _signInWithGoogle() async {
    try {
      setState(() => isLoading = true);

      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => isLoading = false);
        return;
      }

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      final userId = userCredential.user?.uid;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => Dashboardscreen(userId: userId!)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In Failed: ${e.toString()}")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 80),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Column(
                  children: [
                    Text(
                      'Welcome Back!',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff09205f),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Let’s get to work! Sign in now.',
                      style: GoogleFonts.poppins(fontSize: 16),
                    ),
                    const SizedBox(height: 40),
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),
                    const SizedBox(height: 15),
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscureText: true,
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: rememberMe,
                          activeColor: const Color(0xff09205f),
                          onChanged: (value) {
                            setState(() => rememberMe = value ?? false);
                          },
                        ),
                        Text("Remember Me", style: GoogleFonts.poppins()),
                      ],
                    ),
                    const SizedBox(height: 20),
                    isLoading
                        ? const CircularProgressIndicator()
                        : Column(
                      children: [
                        MyButton(
                          onTap: _login,
                          text: 'Login',
                        ),
                        const SizedBox(height: 11),
                        Row(
                          children: const [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text("or"),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                        const SizedBox(height: 11),
                        OutlinedButton.icon(
                          onPressed: _signInWithGoogle,
                          icon: const FaIcon(FontAwesomeIcons.google, color: Colors.green),
                          label: Text(
                            "Sign in with Google",
                            style: GoogleFonts.poppins(fontWeight: FontWeight.w600,color: Colors.black87),
                          ),
                          style: OutlinedButton.styleFrom(
                            minimumSize: const Size.fromHeight(50),
                            side: const BorderSide(color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    const Divider(thickness: 1),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Don't have an account?", style: GoogleFonts.poppins()),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(
                            "Register",
                            style: GoogleFonts.poppins(color: Color(0xff09205f)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ---------------- Custom Text Field ----------------
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      style: GoogleFonts.poppins(),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.poppins(color: Colors.grey),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}

/// ---------------- Custom Button ----------------
class MyButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const MyButton({Key? key, required this.onTap, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color:  Color(0xff09205f),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
