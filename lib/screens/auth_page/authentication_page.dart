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
                // Paw icon
                Icon(Icons.miscellaneous_services_sharp,
                    size: 70, color: Color(0xff151E23)),

                const SizedBox(height: 16),

                // Title
              Text(
                  "Let's Get Started!",
                  style:GoogleFonts.getFont("Inter Tight",fontSize: 30, fontWeight: FontWeight.w600),
                ),


                 Text(
                  "Let's dive in into your account",
                  style: GoogleFonts.getFont("Poppins",fontSize: 12, color: Colors.black87),
                ),

              SizedBox(height: 25),

                // Individual Social Buttons
                _googleButton(),
                _facebookButton(),
                _twitterButton(),

                const SizedBox(height: 24),

                // Sign up button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade500,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context,MaterialPageRoute(builder: (context){
                      return RegisterScreen();
                    }));
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),

                const SizedBox(height: 12),

                // Sign in button
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple.shade50,
                    foregroundColor: Colors.black87,
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                       return LoginScreeno();
                    }));
                  }


                  ,
                  child: const Text("Sign in"),
                ),

                const SizedBox(height: 16),

                Text(
                  "Privacy Policy . Terms of Service",
                  style: GoogleFonts.getFont("Poppins",color: Colors.black, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _googleButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () async{
          // TODO: Handle Google Sign-In
          bool islogged = await login();
          if(islogged){
            Navigator.pushReplacement(context,MaterialPageRoute(builder: (context){
              return Dashboardscreen();
            }));
          }
        },
        icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
        label:  Text(
          "Continue with Google",
          style: GoogleFonts.getFont("Open Sans",color: Colors.black,fontWeight: FontWeight.w600),
        ),
      ),
    );
  }



  Widget _facebookButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // TODO: Handle Facebook Sign-In
        },
        icon: const FaIcon(FontAwesomeIcons.facebook, color: Colors.blue),
        label: Text(
          "Continue with Facebook",
          style: GoogleFonts.getFont("Open Sans",color: Colors.black,fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  Widget _twitterButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        onPressed: () {
          // TODO: Handle Twitter Sign-In
        },
        icon: const FaIcon(FontAwesomeIcons.twitter, color: Colors.lightBlue),
        label:  Text(
          "Continue with Twitter",
          style: GoogleFonts.getFont("Open Sans",color: Colors.black,fontWeight: FontWeight.w600),
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

