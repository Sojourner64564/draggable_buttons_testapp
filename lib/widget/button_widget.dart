import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.color, required this.assetLink});

  final Color color;
  final String assetLink;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(assetLink),
        ),
      ),
    );
  }
}
