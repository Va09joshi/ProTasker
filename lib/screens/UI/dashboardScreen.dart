import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pro_tasker/screens/UI/dashboardUIlayer/Jobs/JobScreen.dart';
import 'package:pro_tasker/screens/UI/dashboardUIlayer/home/HomeScreen.dart';
import 'package:pro_tasker/screens/UI/dashboardUIlayer/map/MapScreen.dart';
import 'package:pro_tasker/screens/UI/dashboardUIlayer/profile/ProfileScreen.dart';

class Dashboardscreen extends StatefulWidget {
  final String userId;

  const Dashboardscreen({super.key, required this.userId});

  @override
  State<Dashboardscreen> createState() => _DashboardscreenState();
}

class _DashboardscreenState extends State<Dashboardscreen> {
  int _selectedindex = 0;
  late List<Widget> _Screenstate;

  final LinearGradient customGradient = const LinearGradient(
    colors: [Color(0xff09205f),Color(0xFF09203f)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  void initState() {
    super.initState();
    _Screenstate = [
      Homescreen(userId: widget.userId),
      Mapscreen(userId: widget.userId),
      JobsScreen(userId: widget.userId),
      ProfileScreen(userId: widget.userId),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: _Screenstate[_selectedindex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: customGradient,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
          child: GNav(
            backgroundColor: Colors.transparent,
            activeColor: Colors.white,
            color: Colors.white70,
            gap: 8,
            selectedIndex: _selectedindex,
            onTabChange: (index) {
              setState(() {
                _selectedindex = index;
              });
            },
            padding: const EdgeInsets.all(16),
            tabBackgroundColor: Colors.white.withOpacity(0.15),
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
