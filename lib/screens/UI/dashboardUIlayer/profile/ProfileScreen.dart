import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:pro_tasker/screens/auth_page/authentication_page.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Dummy numbers – fetch these from Firestore in real app
  final double avgRating = 4;
  final int ratingCount = 217;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
        elevation: 12,
        shadowColor: Colors.black45,
        backgroundColor: Colors.deepPurple.shade400,
        toolbarHeight: 70,
        titleTextStyle: GoogleFonts.lato(
          fontWeight: FontWeight.bold,
          color: Colors.white,
          fontSize: 18,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ── Header with gradient & avatar ─────────────────────────────
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFFa18cd1), Color(0xFFfbc2eb)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -50,
                  left: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.white,
                    child: const CircleAvatar(
                      radius: 55,
                      backgroundImage:
                      NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSQkD3A2dx25cUfdM8Pkq81Kjbnep3h9kEkTg&s'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60), // space for overlapping avatar

            // ── Name, tagline & star rating ───────────────────────────────
            Text(
              'Vaibhav Joshi',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 4),
            Text(
              'Electrician | Plumber',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            RatingBarIndicator(
              rating: avgRating,
              itemBuilder: (_, __) => const Icon(Icons.star, color: Colors.amber),
              itemCount: 5,
              itemSize: 10,
              unratedColor: Colors.amber.withAlpha(60),
              direction: Axis.horizontal,
            ),
            const SizedBox(height: 4),
            Text(
              '$avgRating • $ratingCount reviews',
              style: GoogleFonts.poppins(
                color: Colors.grey.shade600,
                fontSize: 13,
              ),
            ),
            const SizedBox(height: 20),

            // ── Stats cards (now 3 columns) ───────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  _StatCard(
                    label: 'Work',
                    value: '128',
                    icon: FontAwesomeIcons.check,
                    color: theme.primaryColor,
                  ),
                  const SizedBox(width: 12),
                  _StatCard(
                    label: 'Earnings',
                    value: '₹ 50k',
                    icon: FontAwesomeIcons.wallet,
                    color: Colors.green.shade600,
                  ),
                  const SizedBox(width: 12),
                  _StatCard(
                    label: 'Rating',
                    value: avgRating.toStringAsFixed(1),
                    icon: FontAwesomeIcons.solidStar,
                    color: Colors.amber.shade700,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // ── Action list ────────────────────────────────────────────────
            _ActionTile(
              icon: FontAwesomeIcons.userPen,
              label: 'Edit Profile',
              onTap: () {},
            ),
            _ActionTile(
              icon: FontAwesomeIcons.gear,
              label: 'Settings',
              onTap: () {},
            ),
            _ActionTile(
              icon: FontAwesomeIcons.headset,
              label: 'Help & Support',
              onTap: () {},
            ),
            _ActionTile(
              icon: FontAwesomeIcons.arrowRightFromBracket,
              label: 'Logout',
              isDestructive: true,
              onTap: () {
                // FirebaseAuth.instance.signOut();
                FirebaseAuth.instance.signOut().then((val){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
                    return AuthenticationPage();
                  }));
                })
;              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

/// Small white cards for stats
class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String label;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final base = Theme.of(context).textTheme;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              blurRadius: 8,
              offset: Offset(0, 3),
              color: Colors.black12,
            ),
          ],
        ),
        child: Column(
          children: [
            FaIcon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: base.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: base.bodySmall?.copyWith(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tappable list tile with consistent style
class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.icon,
    required this.label,
    required this.onTap,

    this.isDestructive = false,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      color: Colors.white,
      child: ListTile(
        leading: FaIcon(
          icon,
          color: isDestructive ? Colors.red : Colors.grey.shade800,
        ),
        title: Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 16,
            color: isDestructive ? Colors.red : Colors.grey.shade800,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 16),
        onTap: onTap,
      ),
    );
  }
}
