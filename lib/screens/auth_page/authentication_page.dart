import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:pro_tasker/screens/UI/dashboardScreen.dart';
import 'package:pro_tasker/screens/UI/login_screen.dart';
import 'package:pro_tasker/screens/UI/register_screen.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final Color primaryColor = const Color(0xff09205f);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("assets/images/logo4.png", width: 220),

                const SizedBox(height: 24),

                Text(
                  "Let's Get Started!",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: primaryColor,
                  ),
                ),
                Text(
                  "Dive into your account",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 30),

                _googleButton(),
                _facebookButton(),
                _twitterButton(),

                const SizedBox(height: 26),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const RegisterScreen()),
                    );
                  },
                  child: Text(
                    "Sign up",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 12),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[100],
                    foregroundColor: Colors.black87,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreeno()),
                    );
                  },
                  child: Text(
                    "Sign in",
                    style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Privacy Policy • Terms of Service",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.black45,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Google Sign-In Button
  Widget _googleButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton.icon(
        icon: const FaIcon(FontAwesomeIcons.google, color: Colors.red),
        label: Text(
          "Continue with Google",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          side: const BorderSide(color: Color(0xff09205f)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () async {
          final userId = await signInWithGoogle();
          if (userId != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Dashboardscreen(userId: userId)),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Google sign-in failed.")),
            );
          }
        },
      ),
    );
  }

  /// Facebook Stub Button
  Widget _facebookButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton.icon(
        icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
        label: Text(
          "Continue with Facebook",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // TODO: Implement Facebook sign-in
        },
      ),
    );
  }

  /// Twitter Stub Button
  Widget _twitterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton.icon(
        icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
        label: Text(
          "Continue with Twitter",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // TODO: Implement Twitter sign-in
        },
      ),
    );
  }
}

/// Sign-in with Google and return user UID or null
Future<String?> signInWithGoogle() async {
  try {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
    await FirebaseAuth.instance.signInWithCredential(credential);

    return userCredential.user?.uid;
  } catch (e) {
    debugPrint("Google Sign-in error: $e");
    return null;
  }
}
