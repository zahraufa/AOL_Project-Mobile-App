import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'package:eo_app/screens/getStarted_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Organizer App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF102B53)),
        useMaterial3: true,
        fontFamily: GoogleFonts.alexandria().fontFamily,
      ),
      
      builder: (context, child) {
        return Scaffold(
          backgroundColor: Colors.grey[300],
          body: Center(
            child: Container(
              width: 402,
              height: 874,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    spreadRadius: 5,
                  ),
                ],
              ),
              child: child, 
            ),
          ),
        );
      },

      home: const WelcomeScreen(),
    );
  }
}