import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/signup_model.dart';
import '../models/login_model.dart';
import '../models/event_organizer.dart';

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

  // GET eo
  Future<List<EventOrganizerModel>> getEventOrganizers({String? category}) async {
    try {
      String url = '$baseUrl/event-organizer'; 

      if (category != null && category != 'all category') {
        final encodedCategory = Uri.encodeComponent(category);
        url = '$url?category=$encodedCategory';
      }

      print('Menembak API ke: $url');

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final List<dynamic> dataList = responseBody['data'] ?? responseBody;

        if (dataList is! List) return [];

        return dataList
            .map((dynamic item) => EventOrganizerModel.fromJson(item))
            .toList();
      } else {
        print('failed: ${response.body}');
        return [];
      }
    } catch (e) {
      print('Exception getEventOrganizers: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>?> getEoDetails(int id) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/event-organizer/$id'));
      if (response.statusCode == 200) {
        final Map<String, dynamic> body = jsonDecode(response.body);
        final data = body['data'] ?? body;
        return data;
      }
      return null;
    } catch (e) {
      print('Error getEoDetails: $e');
      return null;
    }
  }
}