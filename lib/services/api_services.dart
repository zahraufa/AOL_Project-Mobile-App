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

  //payment
  Future<int?> createTransaction({
    required int eoId,
    required int packageId,
    required List<int> selectedServices,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/transaction'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "event_date": "2026-12-20", 
          "event_location": "Jakarta", 
          "eo_id": eoId,
          "package_id": packageId,
          "selected_services": selectedServices,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['data']['transaction_id'];
      }
      print('Gagal Create Transaction: ${response.body}');
      return null;
    } catch (e) {
      print('Exception Transaction: $e');
      return null;
    }
  }

  Future<int?> createPayment(int transactionId, String paymentMethod) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/payments'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "transaction_id": transactionId,
          "payment_method": paymentMethod,
        }),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        final body = jsonDecode(response.body);
        return body['data']['Payments_ID'];
      }
      print('Gagal Create Payment: ${response.body}');
      return null;
    } catch (e) {
      print('Exception Payment: $e');
      return null;
    }
  }


  Future<bool> confirmPaymentSuccess(int paymentId) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/payments/$paymentId/success'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"message": "Payment success"}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      }
      print('Gagal Confirm Payment: ${response.body}');
      return false;
    } catch (e) {
      print('Exception Confirm Payment: $e');
      return false;
    }
  }
}