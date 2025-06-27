 import 'package:flutter/material.dart';

class Walletscreen extends StatefulWidget {
   const Walletscreen({super.key});

   @override
   State<Walletscreen> createState() => _WalletscreenState();
 }

 class _WalletscreenState extends State<Walletscreen> {
   @override
   Widget build(BuildContext context) {
     return Scaffold(
       body: Center(child: Text("Wallet")),
     );
   }
 }
