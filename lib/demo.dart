import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: SingleChildScrollView(
         child: Container(
          color: Colors.deepPurple,
           child: Padding(
             padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical:10),
             child: GNav(
               backgroundColor: (Colors.deepPurple),
                activeColor: Colors.white,
                color: Colors.white,
                gap: 8,
                padding: EdgeInsets.all(16),
                tabBackgroundColor: Colors.white.withOpacity(0.3),
                tabs: [
                  GButton(icon: Icons.home,text: "Home",),
                  GButton(icon: Icons.location_on,text: "map",),
                  GButton(icon: Icons.settings,text: "setting",),
                  GButton(icon: Icons.account_circle,text: "account",),
                ],
             ),
           ),
         ),
       ),
    );
  }
}
