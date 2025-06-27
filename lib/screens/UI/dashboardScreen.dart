import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import 'package:pro_tasker/screens/UI/dashboardUIlayer/Jobs/JobScreen.dart';
import 'package:pro_tasker/screens/UI/dashboardUIlayer/home/HomeScreen.dart';
import 'package:pro_tasker/screens/UI/dashboardUIlayer/map/MapScreen.dart';
import 'package:pro_tasker/screens/UI/dashboardUIlayer/profile/ProfileScreen.dart';

class Dashboardscreen extends StatefulWidget {
  const Dashboardscreen({super.key});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  int _selectedindex = 0;

  final List<Widget> _Screenstate = [
    Homescreen(),
    Mapscreen(),
    JobsScreen(),
    ProfileScreen(),
  ];

  final LinearGradient customGradient = const LinearGradient(
    colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      /// ✅ Shows selected page
      body: _Screenstate[_selectedindex],

      /// ✅ Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(gradient: customGradient),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            backgroundColor: Colors.transparent,
            activeColor: Colors.white,
            color: Colors.white,
            gap: 8,
            selectedIndex: _selectedindex,
            onTabChange: (index) {
              setState(() {
                _selectedindex = index;
              });
            },
            padding: const EdgeInsets.all(16),
            tabBackgroundColor: Colors.white.withOpacity(0.2),
            tabs: const [
              GButton(icon: Icons.home, text: "Home"),
              GButton(icon: Icons.location_on, text: "Map"),
              GButton(icon: Icons.local_post_office, text: "Post"),
              GButton(icon: Icons.account_circle, text: "Profile"),
            ],
          ),
        ),
      ),
    );
  }
}
