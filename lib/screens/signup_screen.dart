import 'package:eo_app/models/signup_model.dart';
import 'package:eo_app/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:eo_app/widgets/custom_button.dart';
import 'package:eo_app/widgets/custom_text_field.dart';

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
                  image: AssetImage('assets/images/ballroom.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                color: const Color(0xFF1B2A47).withValues(alpha: 0.8),
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.25,
            left: 0,
            right: 0,
            child: const Center(
              child: Text(
                'Get Started',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: size.height * 0.65,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),

              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
                child: Column(
                  children: [
                    CustomTextField(
                      label: 'Username',
                      controller: _usernameController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Email',
                      controller: _emailController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: 'Password',
                      controller: _passwordController,
                      isObscure: true,
                    ),
                    const SizedBox(height: 30),
                    
                    _isLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'Sign up',
                            onPressed: _handleSignup,
                          ),
                    const SizedBox(height: 20),
                    
                    const Text(
                      'already have an account?',
                      style: TextStyle(
                        color: Color(0xFF1B2A47),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 10),
                    
                    CustomButton(
                      text: 'Log in',
                      isOutlined: true,
                      onPressed: () {
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}