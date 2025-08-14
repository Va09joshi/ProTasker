import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_tasker/screens/UI/dashboardUIlayer/home/chatBot/screens/chatScreen.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key, required String userId});

  final List<Map<String, String>> requests = [
    {
      "name": "Rahul S.",
      "time": "2 hours ago",
      "description": "Need electrician urgently In Sector 211",
      "type": "person",
      "avatar": "https://randomuser.me/api/portraits/men/75.jpg",
    },
    {
      "name": "Vaibhav J.",
      "time": "6 hours ago",
      "description": "Need Plumber urgently In Sector 22",
      "type": "person",
      "avatar": "https://randomuser.me/api/portraits/men/65.jpg",
    },
    {
      "name": "Gary M.",
      "time": "1 hour ago",
      "description": "My AC is not working. Need help!",
      "type": "person",
      "avatar": "https://randomuser.me/api/portraits/men/60.jpg",
    },
    {
      "name": "Sambhavna S.",
      "time": "3.5 km away",
      "description": "Need assistance for geyser installation.",
      "type": "person",
      "avatar": "https://randomuser.me/api/portraits/women/75.jpg",
    },
    {
      "name": "Fix leaky faucet",
      "time": "2.4 km away",
      "type": "plumbing",
    },
    {
      "name": "AC repair",
      "time": "1.1 km away",
      "type": "ac",
    },
    {
      "name": "Ceiling fan not working",
      "time": "4 hours ago",
      "type": "electric",
    },
    {
      "name": "Washing machine issue",
      "time": "2.9 km away",
      "type": "appliance",
    },
    {
      "name": "Broken pipe in bathroom",
      "time": "5.6 km away",
      "type": "plumbing",
    },
    {
      "name": "TV installation",
      "time": "Just now",
      "type": "appliance",
    },
  ];

  final LinearGradient customGradient = const LinearGradient(
    colors: [Color(0xFF09203f), Color(0xFF13547a)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false
        ,
        backgroundColor: Color(0xFF09213f),
        toolbarHeight: 90,
        elevation: 6,
        shadowColor: Colors.black,

        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              "assets/images/darklogo.png",
              height: 150,
            ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.solidBell, color: Colors.white),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(FontAwesomeIcons.search, color: Colors.white),
                      ),
                    ],
                   ),
          ],
        ),
      ),
      backgroundColor: Colors.white12,
      floatingActionButton: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ChatScreen();
          }));
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [Color(0xFF09203f), Color(0xFF13547a), Color(0xFF2980B9)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: const Offset(2, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/chatbots.jpeg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "Ask Anything?",
                  style: GoogleFonts.lato(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 36,
              right: 8,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.chat_bubble_outline,
                  color: Colors.blueAccent,
                  size: 18,
                ),
              ),
            ),
          ],
        ),
      ),

        body : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // /// App Bar
              // Container(
              //
              //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              //   decoration: BoxDecoration(
              //     gradient: customGradient,
              //     borderRadius: const BorderRadius.only(
              //       bottomLeft: Radius.circular(20),
              //       bottomRight: Radius.circular(20),
              //     ),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.black.withOpacity(0.3),
              //         offset: const Offset(0, 5),
              //         blurRadius: 12,
              //       )
              //     ],
              //   ),
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //
              //
              //
              //       Row(
              //         children: [
              //           IconButton(
              //             onPressed: () {},
              //             icon: const Icon(FontAwesomeIcons.solidBell, color: Colors.white),
              //           ),
              //           IconButton(
              //             onPressed: () {},
              //             icon: const Icon(FontAwesomeIcons.search, color: Colors.white),
              //           ),
              //         ],
              //       ),
              //     ],
              //   ),
              // ),


              const SizedBox(height: 20),

              /// Post Request
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: customGradient,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.4),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.post_add, size: 40, color: Colors.white),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Post Help Request',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            "Emergency Help Post",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send_sharp, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Requests',
                    style: GoogleFonts.lato(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const Icon(Icons.sort),
                ],
              ),
              const SizedBox(height: 8),

              /// List


      ListView.builder(
      shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: requests.length,
        itemBuilder: (context, index) {
          final req = requests[index];
          bool isPerson = req['type'] == 'person';

          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    if (isPerson)
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: NetworkImage(req['avatar'] ?? ''),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          req['type'] == 'plumbing'
                              ? Icons.plumbing
                              : req['type'] == 'ac'
                              ? Icons.ac_unit
                              : req['type'] == 'electric'
                              ? Icons.electrical_services
                              : req['type'] == 'appliance' &&
                              (req['name']?.toLowerCase().contains('tv') ?? false)
                              ? Icons.tv
                              : req['type'] == 'fan'
                              ? Icons.toys
                              : Icons.build,
                          size: 28,
                          color: Colors.deepPurple,
                        ),
                      ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            req['name'] ?? '',
                            style: GoogleFonts.lato(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            req['time'] ?? '',
                            style: GoogleFonts.lato(
                              fontSize: 13,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                if (req['description'] != null && req['description']!.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: Text(
                      req['description']!,
                      style: GoogleFonts.lato(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up_alt, size: 20, color: Colors.white),
                      label: Text(
                        "Like",
                        style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.check_circle_outline, size: 20),
                      label: Text(
                        "Accept",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green.shade700,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),

        const SizedBox(height: 60),
            ],

          ),

        ),
      ),
    );
  }
}
