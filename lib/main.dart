import 'package:flutter/material.dart';
import 'package:eo_app/screens/';
 
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
        fontFamily: 'Roboto',
      ),
      home: const SearchPage(),
    );
  }
}
 