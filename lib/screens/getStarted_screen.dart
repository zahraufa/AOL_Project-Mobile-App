import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // 1. BG
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/ballroom.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              color: const Color(0xFF0D2546).withValues(alpha: 0.85),
            ),
          ),

          // 2. logo
          Positioned(
            top: size.height * 0.35,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                      'assets/images/logo.png',
                      height: 35,
                      width: 35,
                      fit: BoxFit.contain
                ),
                SizedBox(width: 8),
                Text(
                  'partuisque',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),

          // 3. white field
          Align(
            alignment: Alignment.bottomCenter,
            child: ClipPath(
              clipper: TopCurveClipper(),
              child: Container(
                color: Colors.white,
                width: double.infinity,
                height: size.height * 0.45,
                padding: const EdgeInsets.fromLTRB(32, 60, 32, 32),
                child: Column(
                  children: [
                    const Text(
                      'WELCOME',
                      style: TextStyle(
                        color: Color(0xFF102B53),
                        fontSize: 32,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Find your organizers\neffortlessly',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF6B7A90),
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.3,
                      ),
                    ),
                    const Spacer(),
                    
                    // login button
                    CustomButton(
                      text: 'Login',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    
                    // signup button
                    CustomButton(
                      text: 'Sign up',
                      isOutlined: true,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const SignupScreen()),
                        );
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


class TopCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(0, 50); 
    
    path.quadraticBezierTo(size.width / 2, 0, size.width, 50);
    
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}