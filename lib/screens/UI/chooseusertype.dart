import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_tasker/screens/UI/pagesui/categorypage.dart';
import 'package:pro_tasker/screens/UI/pagesui/intersetpage.dart';

class ChooseUserTypePage extends StatelessWidget {
  final String userId;
  final String email;
  final String password;
  final bool isGoogleSignIn;
  final String name;

  const ChooseUserTypePage({
    super.key,
    required this.userId,
    required this.email,
    required this.password,
    required this.isGoogleSignIn,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "ProTasker",
                style: GoogleFonts.poppins(
                    fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xff09205f)),
              ),
              const SizedBox(height: 3),
              Text(
                "Please choose your account type to continue.",
                style: GoogleFonts.inter(fontSize: 14, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Divider(height: 1, thickness: 1),
              const SizedBox(height: 40),

              // 👤 Service User Card
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => InterestSelectionPage(
                        email: email,
                        password: password,
                        name: name,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent.withOpacity(0.15),
                        child: const Icon(Icons.person_outline, color: Colors.blueAccent),
                        radius: 28,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "I'm a Service User",
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Looking for professionals",
                            style: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // 🛠️ Service Provider Card
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryPage(
                        email: email,
                        password: password,
                        name: name,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.green.withOpacity(0.15),
                        child: const Icon(Icons.handyman, color: Colors.green),
                        radius: 28,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "I'm a Service Provider",
                            style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            "Offering my services",
                            style: GoogleFonts.inter(fontSize: 13, color: Colors.black54),
                          ),
                        ],
                      ),
                      const Spacer(),
                      const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.grey),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
