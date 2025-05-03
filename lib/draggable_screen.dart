import 'package:draggable_buttons_testapp/draggable_page.dart';
import 'package:draggable_buttons_testapp/widget/button_widget.dart';
import 'package:flutter/material.dart';

class DraggableScreen extends StatefulWidget {
  const DraggableScreen({super.key});

  @override
  State<DraggableScreen> createState() => _DraggableScreenState();
}

class _DraggableScreenState extends State<DraggableScreen> {

  int selectedBtnIndex = -1;
  void onTap(int index) {
    setState(() => selectedBtnIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    var menuWidgetList = [
      //TODO навесить onTap
      ButtonWidget(
        color: Colors.teal,
        assetLink: 'assets/img_icons/command_icon.png',
        onTap: () => onTap(0),
      ),
      ButtonWidget(
        color: Colors.lightGreen,
        assetLink: 'assets/img_icons/computer_first_icon.png',
        onTap: () => onTap(1),
      ),
      ButtonWidget(
        color: Colors.indigo,
        assetLink: 'assets/img_icons/computer_second_icon.png',
        onTap: () => onTap(2),
      ),
      ButtonWidget(
        color: Colors.yellow,
        assetLink: 'assets/img_icons/power_plug_icon.png',
        onTap: () => onTap(3),
      ),
    ];
    return Scaffold(
      body: DraggablePage(
        // ignore: prefer_const_literals_to_create_immutables
        menuWidgetList: menuWidgetList,
        animationDuration: 200,
        buttonsWidth: 80,
        widgetHeight: 50,
        backgroundColor: Colors.white,
        selectedBtnIndex: selectedBtnIndex,
      ),
    );
  }
}
