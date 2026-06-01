import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eo_app/screens/signup_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Auth',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF1B2A47), 
        primaryColor: const Color(0xFF1B2A47),
        fontFamily: GoogleFonts.tinos().fontFamily,
      ),
      home: const SignupScreen(), 
    );
  }
}