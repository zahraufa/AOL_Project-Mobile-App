import 'package:eo_app/models/signup_model.dart';
import 'package:eo_app/services/api_services.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget{
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiServices _apiServices = ApiServices();
  bool _isLoading = false;

  void _handleSignup() async {
    setState(() => _isLoading = true);
    
    //INPUT DATA KE MODEL
    final newUser = SignupModel(
      username: _usernameController.text, 
      email: _emailController.text, 
      password: _passwordController.text,
    );

    //KIRIM KE SERVICE
    bool success = await _apiServices.registerUser(newUser);

    setState(() => _isLoading = false);

    //ALERT
    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration successful')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration failed, try again')),
      );
    }
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xFF1B2A47),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.45,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ballroom.jpeg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: const Color(0xFF1B2A47).withValues(alpha: 0.7),
              ),
            ),
          ),

        ],
      )
    );
  }
}