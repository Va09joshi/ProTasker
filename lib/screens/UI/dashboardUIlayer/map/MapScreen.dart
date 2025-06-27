 import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Mapscreen extends StatefulWidget {
   const Mapscreen({super.key});

   @override
   State<Mapscreen> createState() => _MapscreenState();
 }

 class _MapscreenState extends State<Mapscreen> {
  static const LatLng   _pGooglePlex = LatLng(22.978858,76.067178);
  static const LatLng   _pAppPark = LatLng(22.966539, 76.057663);
  static const LatLng _Bnploc = LatLng(22.985817, 76.061515);

  final LinearGradient customGradient = const LinearGradient(
    colors: [Color(0xFF7B1FA2), Color(0xFF512DA8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

    @override
   Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Maps"),
         elevation: 12,
         shadowColor: Colors.black45,
         bottomOpacity: 12,
         centerTitle: true,
         backgroundColor: Colors.deepPurple.shade400,
         titleTextStyle: GoogleFonts.getFont("Lato",fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),
         toolbarHeight: 70,

       ),
       body: GoogleMap(initialCameraPosition: CameraPosition(target: _pGooglePlex,zoom: 15),
       markers: {
         Marker(markerId: MarkerId("current location",),icon: BitmapDescriptor.defaultMarker,position: _pGooglePlex),
         Marker(markerId: MarkerId("Source location",),icon: BitmapDescriptor.defaultMarker,position: _pAppPark,),
         Marker(markerId: MarkerId("BNP location",),icon: BitmapDescriptor.defaultMarker,position: _Bnploc)
       },
       ),
     );
   }
 }
