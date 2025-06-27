import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pro_tasker/screens/UI/dashboardUIlayer/home/chatBot/screens/chatScreen.dart';

class Homescreen extends StatelessWidget {
  Homescreen({super.key});

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
    colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
           return ChatScreen();
        }));
      },child: Icon(Icons.chat,color: Colors.white,),backgroundColor: Colors.deepPurple.shade400,),
      body : SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// App Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                decoration: BoxDecoration(
                  gradient: customGradient,
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      offset: const Offset(0, 5),
                      blurRadius: 12,
                    )
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ProTasker',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
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
                                radius: 24,
                                backgroundImage: NetworkImage(req['avatar'] ?? ''),
                              )
                            else
                              Icon(
                                req['type'] == 'plumbing'
                                    ? Icons.plumbing
                                    : req['type'] == 'ac'
                                    ? Icons.ac_unit
                                    : req['type'] == 'electric'
                                    ? Icons.electrical_services
                                    : req['type'] == 'appliance' && (req['name']?.toLowerCase().contains('tv') ?? false)
                                    ? Icons.tv
                                    : req['type'] == 'fan'
                                    ? Icons.toys
                                    : Icons.build,
                                size: 28,
                                color: Colors.black54,
                              ),
      
      
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(req['name'] ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          overflow: TextOverflow.ellipsis)),
                                  Text(req['time'] ?? '',
                                      style: const TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        if (req['description'] != null && req['description']!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              req['description']!,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.thumb_up_alt_outlined,color: Colors.pinkAccent,),
                              label:  Text("Like",style: GoogleFonts.getFont("Inter Tight",color: Colors.pinkAccent,fontWeight: FontWeight.bold),),
                              
                            ),
                            ElevatedButton.icon(
                              onPressed: () {},
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text("Accept"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green.shade800,
                                foregroundColor: Colors.white,
                              ),
                            ),
                          ],
                        )
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
