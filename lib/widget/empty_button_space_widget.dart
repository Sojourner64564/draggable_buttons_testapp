import 'package:flutter/material.dart';

class EmptyButtonSpaceWidget extends StatelessWidget {
  const EmptyButtonSpaceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: 50,
        height: 50,
        color: Colors.transparent,
      ),
    );  }
}
