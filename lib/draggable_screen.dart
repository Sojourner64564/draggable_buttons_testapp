import 'package:draggable_buttons_testapp/draggable_page.dart';
import 'package:draggable_buttons_testapp/widget/button_widget.dart';
import 'package:flutter/material.dart';

class DraggableScreen extends StatelessWidget {
  const DraggableScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DraggablePage(
        // ignore: prefer_const_literals_to_create_immutables
        menuWidgetList: [
          const ButtonWidget(color: Colors.teal, assetLink: 'assets/img_icons/command_icon.png',),
          const ButtonWidget(color: Colors.lightGreen, assetLink: 'assets/img_icons/computer_first_icon.png',),
          const ButtonWidget(color: Colors.indigo, assetLink: 'assets/img_icons/computer_second_icon.png',),
          const ButtonWidget(color: Colors.yellow, assetLink: 'assets/img_icons/power_plug_icon.png',),
        ],
        animationDuration: 2000,
      ),
    );
  }
}
