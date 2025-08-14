import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_tasker/screens/UI/dashboardScreen.dart';

class CategoryPage extends StatefulWidget {
  final String email;
  final String password;
  final String name; // ✅ Added name

  const CategoryPage({
    Key? key,
    required this.email,
    required this.password,
    required this.name, // ✅ Accept name
  }) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  String? _selectedCategory;
  bool _validationFailed = false;
  bool _isLoading = false;

  final List<String> _categories = [
    'Plumber',
    'Electrician',
    'Carpenter',
    'Painter',
    'Mechanic',
    'Gardener',
    'House Cleaning',
    'AC Repair',
  ];

  Future<void> _handleSignupAndContinue() async {
    if (_selectedCategory == null) {
      setState(() {
        _validationFailed = true;
      });
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Firebase Auth signup
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      final userId = userCredential.user!.uid;

      // Save to Firestore
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'userId': userId,
        'name': widget.name,               // ✅ Save name
        'email': widget.email,
        'category': _selectedCategory,
        'signedUp': true,
        'userType': 'provider',            // ✅ Optional: you may define userType here
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Navigate to Dashboard
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => Dashboardscreen(userId: userId),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong. Try again.';
      if (e.code == 'email-already-in-use') {
        message = 'This email is already registered.';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak.';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email format.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Signup failed. Please try again.'),
          backgroundColor: Colors.red,
        ),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff0f4f8),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Center(
              child: Text(
                'Choose Your Category',
                style: GoogleFonts.poppins(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 11),
            const Divider(height: 1, thickness: 1),
            const SizedBox(height: 30),
            Center(
              child: Text(
                'Select a category you belong to:',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: const Color(0xff09205f),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                childAspectRatio: 3,
                children: _categories.map((category) {
                  final isSelected = _selectedCategory == category;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category;
                        _validationFailed = false;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color: isSelected ? const Color(0xff09205f) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? const Color(0xff09205f) : Colors.grey.shade300,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 4,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        category,
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (_validationFailed)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  '⚠️ Please select a category',
                  style: GoogleFonts.poppins(color: Colors.red),
                ),
              ),
            const SizedBox(height: 15),
            ElevatedButton(
              onPressed: _isLoading ? null : _handleSignupAndContinue,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xff09205f),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : Text(
                'Continue',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
