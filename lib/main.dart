import 'package:eo_app/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

import 'screens/home_screen.dart';
import 'screens/search_page.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CustomTextField(),
    );
  }
}