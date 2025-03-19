import 'package:draggable_buttons_testapp/widget/button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DraggablePage extends StatefulWidget {
  const DraggablePage({super.key});


  @override
  State<DraggablePage> createState() => _DraggablePageState();
}

class _DraggablePageState extends State<DraggablePage> {
  bool isVisibleChildWhenDragging = true;
  int invisibleItem = -1;

  List<Widget> buttonsList = [
    const ButtonWidget(color: Colors.deepOrange),
    const ButtonWidget(color: Colors.lightGreen),
    const ButtonWidget(color: Colors.deepPurple),
    const ButtonWidget(color: Colors.blueAccent),
  ];


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.grey,
                width: 350,
                height: 165,
                child: Column(
                  children: [
                    /*Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        width: 350,
                        height: 50,
                        child: Stack(
                          children: List.generate(buttonsList.length, (index){
                            return Positioned(
                                left: (80*index).toDouble(),
                                child: Visibility(
                                  visible: !(invisibleItem==index),
                                    child: buttonsList[index],
                                ),
                            );
                          },
                          ),
                        ),
                      ),
                    ),*/
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        width: 350,
                        height: 50,
                        child: Row(
                          children: List.generate(
                            buttonsList.length, (index){
                              return Visibility(
                                  visible: !(invisibleItem==index),
                                  child: buttonsList[index],
                              );
                          },
                          ),
                        ),
                      ),
                    ),
                    MouseRegion(
                      onHover: (event){
                        print(event.localPosition.dx);
                      },
                      onEnter: (PointerEnterEvent pointer){
                        isVisibleChildWhenDragging = true;
                      },
                      onExit: (PointerExitEvent pinter){
                        isVisibleChildWhenDragging = false;
                      },
                      child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: LayoutBuilder(
                            builder: (BuildContext context, BoxConstraints constraints) {
                              return Row(
                                children: List.generate(
                                  buttonsList.length,
                                  (index) {
                                    return Draggable(
                                      data: index,
                                      feedback: buttonsList[index],
                                      onDraggableCanceled: (Velocity velocity, Offset offset){
                                        if(!context.mounted) return;
                                        setState(() {
                                          invisibleItem = -1;
                                        });
                                      },
                                      onDragCompleted: (){
                                        setState(() {
                                          invisibleItem = -1;
                                        });
                                    },
                                      onDragUpdate: (DragUpdateDetails dragUpdateDetails){
                                        //TODO с помощью дельты сделать чтобы кубик не исчезал с первым движением
                                        //print("dragUpdateDetails ${dragUpdateDetails.delta.dy}");
                                        invisibleItem = index;

                                        ///TODO как-то оптимизировать этот момент
                                        setState(() {});
                                      },
                                      childWhenDragging: Visibility(
                                        visible: isVisibleChildWhenDragging,
                                        child: const SizedBox(
                                          width: 80,
                                          height: 50,
                                        ),
                                      ),
                                      child: DragTarget<int>(
                                        builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
                                          return buttonsList[index];
                                        },
                                        onMove: (DragTargetDetails<int> details){
                                         // final fdf  = constraints.
                                          final maxWidth = MediaQuery.of(context).size.width;
                                          final halfWidth = maxWidth;


                                        },

                                        onAcceptWithDetails: (DragTargetDetails<int> details){
                                          setState(() {
                                            final buttonWidget = buttonsList[index];
                                            buttonsList[index] = buttonsList[details.data];
                                            buttonsList[details.data] = buttonWidget;
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            }
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
