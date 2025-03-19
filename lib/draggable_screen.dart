import 'package:draggable_buttons_testapp/draggable_page.dart';
import 'package:flutter/material.dart';

class DraggableScreen extends StatelessWidget {
  const DraggableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggablePage(),
    );
  }
}
