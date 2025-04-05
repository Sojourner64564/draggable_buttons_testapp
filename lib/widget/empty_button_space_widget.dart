import 'package:flutter/material.dart';

class EmptyButtonSpaceWidget extends StatelessWidget {
  const EmptyButtonSpaceWidget({super.key, required this.widgetWidth});
  final double widgetWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widgetWidth,
      height: 50,
      color: Colors.transparent,
    );
  }
}
