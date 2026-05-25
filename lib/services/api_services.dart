import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/signup_model.dart';

class ApiServices {
  final String baseUrl = ''; //api zara

  Future<bool> registerUser(SignupModel user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200){
        return true;
      } else {
        print('Error: ${response.body}');
        return false;
      }
    } catch (e){
      print('Exception: $e');
      return false;
    }
  }
}