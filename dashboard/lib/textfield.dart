import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String hitText;
  final bool obscureText;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hitText,
    required this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.white,
                ),
            ),
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.white
                ),
            ),
            fillColor: Colors.grey.shade100,
            filled: true,
          hintText: hitText,
          hintStyle: TextStyle(
              color:  Colors.grey[900])
        ),
      ),
    );
  }
}
