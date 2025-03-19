import 'dart:developer';

import 'package:flutter/material.dart';

class ValueKeyExample1 extends StatefulWidget {
  const ValueKeyExample1({Key? key}) : super(key: key);

  @override
  StatefulElement createElement() {
    print("ValueKeyExample1 createElement statefull");
    return  StatefulElement(this);
  }

  @override
  _ValueKeyExample1State createState() => _ValueKeyExample1State();
}

class _ValueKeyExample1State extends State<ValueKeyExample1> {
  late int counter;

  @override
  void initState() {
    log('# ValueKeyExample1 init state');
    counter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('ValueKeyExample1 - call method build(context)');
    return Scaffold(
      appBar: AppBar(
        title: const Text('ValueKey Example 1'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          key: ValueKey(2),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ScaleAnimated(
              key: ValueKey(1+1),

              duration: const Duration(seconds: 2),
              child: Text("Виджет без ключа: $counter",
                  style: const TextStyle(fontSize: 30)),
            ),
            ScaleAnimated(
              key: ValueKey(counter),
              duration: const Duration(seconds: 2),
              child: MyTextWidget(
                text: "Виджет с ключом:",
                counter: counter,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  counter++;
                });
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                backgroundColor: Colors.grey,
                textStyle: const TextStyle(fontSize: 20),
              ),
              child: const Text("Нажми меня"),
            ),
          ],
        ),
      ),
    );
  }
}
class MyTextWidget extends StatelessWidget{
  const MyTextWidget({super.key, required this.counter, required this.text});
  final int counter;
  final String text;

  @override
  StatelessElement createElement() {
    print("MyTextWidget createElement stateless");
    return  StatelessElement(this);
  }

  @override
  Widget build(BuildContext context) {
    return Text("$text $counter",
        style: const TextStyle(fontSize: 30));
  }
}

class ScaleAnimated extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const ScaleAnimated({Key? key, required this.child, required this.duration})
      : super(key: key);

  @override
  StatefulElement createElement() {
    print("ScaleAnimated createElement");
    return  StatefulElement(this);
  }


  @override
  _ScaleAnimatedState createState() => _ScaleAnimatedState();
}

class _ScaleAnimatedState extends State<ScaleAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    log('# ScaleAnimated init state');
    _controller = AnimationController(
        vsync: this,
        duration: widget.duration,
        upperBound: 1.0,
        lowerBound: 0.0);
    _controller.forward();
    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    log('ScaleAnimated - call methos build(context)');
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}