import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CustomTextField extends StatelessWidget{
  final String label;
  final bool isObscure;
  final TextEditingController controller;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
    this.isObscure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Color(0xFF102b53),
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'Tinos',
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFABBCD6),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
            controller: controller,
            obscureText: isObscure,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}