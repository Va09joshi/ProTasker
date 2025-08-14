import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_tasker/screens/UI/dashboardScreen.dart';

class InterestSelectionPage extends StatefulWidget {
  final String email;
  final String password;
  final String name; // <-- Add name here

  const InterestSelectionPage({
    Key? key,
    required this.email,
    required this.password,
    required this.name, // <-- Add this
  }) : super(key: key);

  @override
  State<InterestSelectionPage> createState() => _InterestSelectionPageState();
}

class _InterestSelectionPageState extends State<InterestSelectionPage> {
  final List<String> allInterests = [
    'Leak Fixing',
    'Pipe Installation',
    'Tap Repair',
    'Drainage Issue',
    'Water Heater Setup',
    'Emergency Services',
  ];

  Set<String> selectedInterests = {};
  bool _validationFailed = false;
  final Color primaryColor = const Color(0xff09205f);

  Future<void> _handleContinue() async {
    if (selectedInterests.isEmpty) {
      setState(() {
        _validationFailed = true;
      });
      return;
    }

    try {
      // Sign up with email & password
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      final userId = userCredential.user?.uid;
      if (userId == null) throw Exception("User creation failed");

      final userDocRef =
      FirebaseFirestore.instance.collection('users').doc(userId);

      await userDocRef.set({
        'email': widget.email,
        'name': widget.name, // <-- Add name here
        'userType': 'user',
        'interests': selectedInterests.toList(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Dashboardscreen(userId: userId),
        ),
      );
    } catch (e) {
      print('Sign-up or Firestore error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Widget _buildInterestChip(String interest) {
    final isSelected = selectedInterests.contains(interest);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedInterests.remove(interest);
          } else {
            selectedInterests.add(interest);
            _validationFailed = false;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: isSelected ? primaryColor : Colors.grey.shade400,
            width: 1.5,
          ),
          boxShadow: [
            if (isSelected)
              BoxShadow(
                color: primaryColor.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              )
          ],
        ),
        child: Text(
          interest,
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Select Your Interests',
                  style: GoogleFonts.poppins(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 11),
              const Divider(height: 1, thickness: 1),
              const SizedBox(height: 30),
              Center(
                child: Text(
                  'What services are you interested in?',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: primaryColor,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'You can select multiple options.',
                  style: GoogleFonts.inter(
                      fontSize: 14, color: Colors.black54),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    children: allInterests.map(_buildInterestChip).toList(),
                  ),
                ),
              ),
              if (_validationFailed)
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    '⚠️ Please select at least one interest',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _handleContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    'Continue',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
