import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // 1. Tetap import Google Fonts
import 'package:eo_app/screens/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // 2. Mengikuti format terbaru dari teman Anda

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Organizer App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF102B53), // Warna dasar dari teman Anda
        ),
        useMaterial3: true,
        // 3. Set Tinos sebagai font global aplikasi
        fontFamily: GoogleFonts.tinos().fontFamily, 
      ),
      home: const SignupScreen(),
    );
  }
}