import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../UI/chooseusertype.dart';

import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  Future<void> _proceedToNext() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all the fields")),
      );
      return;
    }

    setState(() => isLoading = true);

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ChooseUserTypePage(
            userId: userCredential.user!.uid,
            name: name,
            email: email,
            password: password,
            isGoogleSignIn: false,
          ),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("This email is already registered.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${e.message}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Unexpected error: $e")),
      );
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _googleContinue() async {
    try {
      setState(() => isLoading = true);

      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() => isLoading = false);
        return;
      }

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
      await FirebaseAuth.instance.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ChooseUserTypePage(
              userId: user.uid,
              name: user.displayName ?? '',
              email: user.email ?? '',
              password: '',
              isGoogleSignIn: true,
            ),
          ),
        );
      }
    } catch (e) {
      print("Google sign-in error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Google sign-in failed")),
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
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Create Account',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey.shade900,
                  ),
                ),
              ),
              const SizedBox(height: 3),
              Center(
                child: Text(
                  'Fill in your details to create an account',
                  style: GoogleFonts.poppins(fontSize: 16),
                ),
              ),
              const SizedBox(height: 40),

              MyTextField(
                controller: nameController,
                hintText: 'Full Name',
                obscureText: false,
              ),
              const SizedBox(height: 15),

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
              const SizedBox(height: 30),

              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                children: [
                  MyButton(
                    onTap: _proceedToNext,
                    text: 'Continue',
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding:
                        const EdgeInsets.symmetric(horizontal: 10),
                        child: Text("or",
                            style: GoogleFonts.poppins(fontSize: 14)),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 20),
                  OutlinedButton.icon(
                    onPressed: _googleContinue,
                    icon: const Icon(
                      FontAwesomeIcons.google,
                      color: Colors.green,
                    ),
                    label: Text(
                      "Continue with Google",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      side: const BorderSide(color: Colors.black26),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Divider(height: 1, thickness: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: GoogleFonts.poppins()),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Sign In",
                      style: GoogleFonts.poppins(
                        color: const Color(0xff09205f),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
