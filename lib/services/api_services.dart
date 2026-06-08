import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/signup_model.dart';
import '../models/login_model.dart';

class ApiServices {
  final String baseUrl = 'https://aolproject-mobile-app-production.up.railway.app';

  // SIGN UP
  Future<bool> registerUser(SignupModel user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/autho/signup'), 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200){
        print('Signup Success!');
        return true;
      } else {
        print('Signup Error: ${response.body}');
        return false;
      }
    } catch (e){
      print('Exception Signup: $e');
      return false;
    }
  }

  // LOGIN
  Future<bool> loginUser(LoginModel user) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/autho/login'), 
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print('Login Success!');
        return true; 
      } else {
        print('Login Error: ${response.body}');
        return false;
      }
      
    } catch (e) {
      print('Exception Login: $e');
      return false;
    }
  }
}