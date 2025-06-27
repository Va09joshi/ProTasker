import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class JobsScreen extends StatefulWidget {
  const JobsScreen({Key? key}) : super(key: key);

  @override
  State<JobsScreen> createState() => _JobsScreenState();
}

class _JobsScreenState extends State<JobsScreen> {
  // 0 = Ongoing, 1 = Completed
  int _segmentIndex = 0;

  // ---------------------------------------------------------------------------
  // EXTRA JOBS (NEW)
  // ---------------------------------------------------------------------------
  final List<_Job> _moreJobs = [
    _Job(
      name: 'Vaibhav J.',
      when: 'Today, 5:30 PM',
      address: '22 Market Rd',
      distance: '5.1 km away',
    ),
    _Job(
      name: 'Slash Verma',
      when: 'Tomorrow, 11:00 AM',
      address: '7/3 Ring Rd',
      distance: '3.0 km away',
    ),
  ];

  // quick helper ─ reuse for every white rounded card on this page
  BoxDecoration get _card => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(.05),
        blurRadius: 8,
        offset: const Offset(0, 4),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    const Gradient customGradient = LinearGradient(
      colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      // -----------------------------------------------------------------------
      //  FAB  ➕  (NEW)
      // -----------------------------------------------------------------------
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddJobSheet,
        child: const Icon(Icons.add,color: Colors.white,),
        backgroundColor: Colors.deepPurple,
      ),

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            // HEADER
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
                    color: Colors.black.withOpacity(.3),
                    offset: const Offset(0, 5),
                    blurRadius: 12,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Jobs',
                    style: GoogleFonts.lato(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    splashRadius: 22,
                    icon: const Icon(FontAwesomeIcons.solidComments,
                        color: Colors.white),
                    onPressed: () {
                      // TODO: open chat-list screen
                    },
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ─────────── Segmented “Ongoing / Completed” ───────────
            Center(
              child: CupertinoSegmentedControl<int>(
                groupValue: _segmentIndex,
                padding: const EdgeInsets.all(4),
                selectedColor: Colors.deepPurple,
                borderColor: Colors.deepPurple,
                children: const {
                  0: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    child: Text('Ongoing'),
                  ),
                  1: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    child: Text('Completed'),
                  ),
                },
                onValueChanged: (v) => setState(() => _segmentIndex = v),
              ),
            ),

            const SizedBox(height: 24),

            // ----------------------------------------------------------------
            // ORIGINAL FIRST CARD (UNCHANGED)
            // ----------------------------------------------------------------
            _currentJobCard(),

            // ----------------------------------------------------------------
            // EXTRA CARDS (NEW) – keep same styling
            // ----------------------------------------------------------------
            ..._moreJobs.map(_extraJobCard).toList(),

            const SizedBox(height: 32),

            // ───────────────── Job history header ─────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'JOB DETAILS',
                style: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .8,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ───────────────── History list tile ─────────────────
            _historyTile(title: 'Pipe Installation', when: 'Yesterday'),
            SizedBox(
              height: 21,
            ),
            _historyTile(title: "AC Repair", when: "Today"),
            SizedBox(height: 21,),
            _historyTile(title: "Tv Installation", when: "Monday"),
            SizedBox(height: 21,),
            _historyTile(title: 'PLumber Needed', when: 'Today'),
            SizedBox(
              height: 21,
            ),
            _historyTile(title: "Paint A Home", when: "Friday"),
            SizedBox(height: 21,),
            _historyTile(title: "Tv Installation", when: "Tommorrow")
          ],
        ),
      ),
    );
  }

  // ===========================================================================
  // ORIGINAL WIDGET (UNCHANGED)
  // ===========================================================================
  Widget _currentJobCard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // title + “Chat”
        Row(
          children: [
            Expanded(
              child: Text('Fan Repair',
                  style: GoogleFonts.lato(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),

            TextButton(
              onPressed: () {},
              child: Text('Chat',
                  style: GoogleFonts.lato(fontWeight: FontWeight.w600,color: Colors.redAccent)),
            )
          ],
        ),
        const SizedBox(height: 4),
        Text('Today, 2:00 PM',
            style:
            GoogleFonts.lato(fontSize: 13, color: Colors.grey.shade600)),

        const SizedBox(height: 16),

        // ── Customer card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: _card,
          child: Row(
            children: [
              // location pin
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0x265A7FFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(FontAwesomeIcons.locationDot,
                    size: 16, color: Colors.blueAccent),
              ),
              const SizedBox(width: 12),
              // name + addr
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Anjali M.',
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text('125.6 km St',
                        style: GoogleFonts.lato(
                            fontSize: 13, color: Colors.grey.shade600)),
                    const SizedBox(height: 2),
                    Text('2.4 km away',
                        style: GoogleFonts.lato(
                            fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              // call icon
              InkWell(
                onTap: () {}, // TODO: dial number
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0x2634C759),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(FontAwesomeIcons.phone,
                      size: 16, color: Colors.green),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        // ── QR / code section header
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text('JOB DETAIL',
              style: GoogleFonts.lato(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: .8,
                  color: Colors.grey.shade700)),
        ),

        // ── QR / code card
        Container(
          padding: const EdgeInsets.all(16),
          decoration: _card,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Color(0x26FF9F0A), shape: BoxShape.circle),
                    child: const Icon(FontAwesomeIcons.qrcode,
                        size: 18, color: Colors.orange),
                  ),
                  const SizedBox(width: 12),
                  Text('Scan QR to Complete',
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.bold, fontSize: 15)),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {}, // TODO: manual code flow
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade300,
                    foregroundColor: Colors.black54,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('OR CODE'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===========================================================================
  // EXTRA JOB CARD  (NEW)
  // ===========================================================================
  Widget _extraJobCard(_Job j) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text('Pipe Repair', // same title throughout
                  style: GoogleFonts.lato(
                      fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Chat',
                  style: GoogleFonts.lato(fontWeight: FontWeight.w600,color: Colors.redAccent)),
            )
          ],
        ),
        const SizedBox(height: 4),
        Text(j.when,
            style:
            GoogleFonts.lato(fontSize: 13, color: Colors.grey.shade600)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: _card,
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Color(0x265A7FFF),
                  shape: BoxShape.circle,
                ),
                child: const Icon(FontAwesomeIcons.locationDot,
                    size: 16, color: Colors.blueAccent),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(j.name,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.bold, fontSize: 15)),
                    const SizedBox(height: 2),
                    Text(j.address,
                        style: GoogleFonts.lato(
                            fontSize: 13, color: Colors.grey.shade600)),
                    const SizedBox(height: 2),
                    Text(j.distance,
                        style: GoogleFonts.lato(
                            fontSize: 13, color: Colors.grey.shade600)),
                  ],
                ),
              ),
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: Color(0x2634C759),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(FontAwesomeIcons.phone,
                      size: 16, color: Colors.green),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ===========================================================================
  // ORIGINAL HISTORY TILE (UNCHANGED)
  // ===========================================================================
  Widget _historyTile({required String title, required String when}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: _card,
      child: Row(
        children: [
          Expanded(
            child: Text(title,
                style: GoogleFonts.lato(
                    fontSize: 15, fontWeight: FontWeight.w600)),
          ),
          Text(when,
              style:
              GoogleFonts.lato(fontSize: 13, color: Colors.grey.shade600)),
        ],
      ),
    );
  }

  // ===========================================================================
  // BOTTOM-SHEET  (NEW)
  // ===========================================================================
  void _showAddJobSheet() {
    final _titleC = TextEditingController();
    final _reasonC = TextEditingController();
    final _priceC = TextEditingController();

    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text("Provide Your Jobs",style: GoogleFonts.getFont("Lato",fontSize: 24,fontWeight: FontWeight.bold,color : Colors.black,shadows: [

              Shadow(
                offset: Offset(2, 2),
                blurRadius: 10,
                color: Colors.grey,
              )
            ]),),

            Text("Searching for local work, ready to start",style: GoogleFonts.getFont("Inter",fontSize: 10,shadows: [

            ]),),

            SizedBox(
              height: 30,
            ),
            _textField(_titleC, 'Job Title....',"title"),
            const SizedBox(height: 12),
            _textField(_reasonC, 'Your Location...',"Address"),
            const SizedBox(height: 12),
            _textField(_priceC, 'Price (₹)...',"Price",
                inputType: TextInputType.number),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    onPressed: () {
                      setState(() {
                        _moreJobs.add(_Job(
                          name: _titleC.text.isEmpty ? 'New Client' : _titleC.text,
                          when: 'Now',
                          address: _reasonC.text,
                          distance: '${_priceC.text} km',
                        ));
                      });
                      Navigator.pop(ctx);
                    },
                    child: const Text('Send',style: TextStyle(color: Colors.white),),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple.shade50),
                    onPressed: () => Navigator.pop(ctx),
                    child: const Text('close'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // helper for text fields (NEW)
  Widget _textField(TextEditingController c, String hint,String label,
      {TextInputType inputType = TextInputType.text} ) =>
      TextField(
        controller: c,
        keyboardType: inputType,

        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.deepPurple,fontWeight: FontWeight.bold),
          hintText: hint,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black54
            )
          )
        ),
      );
}

// -----------------------------------------------------------------------------
// SIMPLE JOB MODEL  (NEW)
// -----------------------------------------------------------------------------
class _Job {
  final String name, when, address, distance;
  _Job({
    required this.name,
    required this.when,
    required this.address,
    required this.distance,
  });
}
