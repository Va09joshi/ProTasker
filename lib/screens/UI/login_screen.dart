import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_tasker/screens/UI/dashboardScreen.dart';
import 'package:pro_tasker/screens/UI/register_screen.dart';

import '../auth/auth_service.dart';

class LoginScreeno extends StatefulWidget {
  const LoginScreeno({super.key});

  @override
  State<LoginScreeno> createState() => _LoginScreenoState();
}

class _LoginScreenoState extends State<LoginScreeno> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final AuthService _auth = AuthService();



  bool rememberMe = false;
  bool showPassword = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void _login() async {
    String? result = await _auth.signIn(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );

    if (result == null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Dashboardscreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),

            Text(
              "Welcome Back! 👋",
              style: GoogleFonts.getFont("Inter Tight",
                  fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 1),
            Text(
              "Let's continue the journey with the peoples.",
              style: GoogleFonts.getFont("Inter",
                  fontSize: 12, color: Colors.black87),
            ),
            const SizedBox(height: 30),

            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 20),

            TextField(
              controller: passwordController,
              obscureText: !showPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                prefixIcon: const Icon(Icons.lock_outline),
                suffixIcon: IconButton(
                  icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black87),
                ),
              ),
            ),
            const SizedBox(height: 10),

            Row(
              children: [
                Checkbox(
                  value: rememberMe,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value!;
                    });
                  },
                  activeColor: Colors.deepPurple,
                ),
                const Text("Remember me"),
              ],
            ),
            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  _login();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff09205f),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Sign in",
                  style: GoogleFonts.getFont("Inter",
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),

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
            const SizedBox(height: 10),

            OutlinedButton.icon(
              onPressed: () async {
                // Google sign-in logic

                bool islogged = await login();
                if(islogged){
                  Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
                     return Dashboardscreen();
                  }));
                }
              },
              icon: const Icon(FontAwesomeIcons.google,
                  size: 25, color: Colors.black87),
              label: Text(
                "Continue with Google",
                style: GoogleFonts.getFont("Inter",
                    color: Colors.black87, fontWeight: FontWeight.w600),
              ),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.black54),
              ),
            ),
            const SizedBox(height: 11),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: GoogleFonts.getFont("Inter Tight",
                      fontWeight: FontWeight.w500),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return RegisterScreen();
                        }));
                  },
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.getFont("Inter",
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 22,),
            Center(child: Text("Powered And Handled",style: GoogleFonts.getFont("Lato",fontSize: 14,fontWeight: FontWeight.bold),)),
            Center(child: Text("By",style: GoogleFonts.getFont("Lato",fontSize: 14,fontWeight: FontWeight.bold),)),

            Center(child: Image.asset("assets/images/logo2.png",width: 170,)),
          ],
        ),
      ),
    );
  }

 Future<bool> login() async {
     final user = await GoogleSignIn().signIn();
     GoogleSignInAuthentication userAuth = await user!.authentication;
     var credential = GoogleAuthProvider.credential(idToken: userAuth.idToken,accessToken: userAuth.accessToken );

     FirebaseAuth.instance.signInWithCredential(credential);

     return await FirebaseAuth.instance.currentUser!=null;
  }
}
