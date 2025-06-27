 import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pro_tasker/screens/UI/login_screen.dart';

import '../auth/auth_service.dart';
import '../auth_page/authentication_page.dart';
import 'dashboardScreen.dart';

class RegisterScreen extends StatefulWidget {
   const RegisterScreen({super.key});

   @override
   State<RegisterScreen> createState() => _RegisterScreenState();
 }

 class _RegisterScreenState extends State<RegisterScreen> {
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
   void _register() async {
     String? result = await _auth.signUp(
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
       backgroundColor: Colors.white.withOpacity(0.98),
       body: SingleChildScrollView(
         padding: const EdgeInsets.all(20),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 100),

             Text(
               "Join With Us 👋🏿",
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
                  Text("I agree to ",),
                  Text("Terms & Conditions.",style: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.w500),)
               ],
             ),
             const SizedBox(height: 10),

             SizedBox(
               width: double.infinity,
               height: 50,
               child: ElevatedButton(
                 onPressed: ()async {
                     _register();
                 },
                 style: ElevatedButton.styleFrom(
                   backgroundColor: Colors.deepPurple.shade500,
                   shape: RoundedRectangleBorder(
                     borderRadius: BorderRadius.circular(30),
                   ),
                 ),
                 child: Text(
                   "Sign up",
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
                   "Already have an account?",
                   style: GoogleFonts.getFont("Inter Tight",
                       fontWeight: FontWeight.w500),
                 ),
                 TextButton(
                   onPressed: () {
                     Navigator.push(context,
                         MaterialPageRoute(builder: (context) {
                           return LoginScreeno();
                         }));
                   },
                   child: Text(
                     "Sign In",
                     style: GoogleFonts.getFont("Inter",
                         color: Colors.deepPurple, fontWeight: FontWeight.bold),
                   ),
                 ),
               ],
             ),
           ],
         ),
       ),
     );
   }
 }

 Future<bool> login() async {
   final user = await GoogleSignIn().signIn();
   GoogleSignInAuthentication userAuth = await user!.authentication;
   var credential = GoogleAuthProvider.credential(idToken: userAuth.idToken,accessToken: userAuth.accessToken );

   FirebaseAuth.instance.signInWithCredential(credential);

   return await FirebaseAuth.instance.currentUser!=null;
 }

