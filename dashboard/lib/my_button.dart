import 'package:flutter/material.dart';

class MyBotton extends StatelessWidget {
  final Function()? onTap;
  const MyBotton({
    super.key,
    required this.onTap,
});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25.0),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          borderRadius: BorderRadius.circular(10)
        ),
        child: const Center(
          child: Text("sign in",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25.0,
              fontWeight: FontWeight.bold
            ),
          ),
        ),
      ),
    );
  }
}
