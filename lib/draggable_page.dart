import 'package:draggable_buttons_testapp/controller/move_buttons_cubit.dart';
import 'package:draggable_buttons_testapp/widget/button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DraggablePage extends StatefulWidget {
  DraggablePage({super.key});

  final MoveButtonsCubit moveButtonsCubit = MoveButtonsCubit();

  @override
  State<DraggablePage> createState() => _DraggablePageState();
}

class _DraggablePageState extends State<DraggablePage> {
  final GlobalKey widgetKey = GlobalKey();
  bool isVisibleChildWhenDragging = true;
  int invisibleItem = -1;

  List<Widget> buttonsList = [
    const ButtonWidget(color: Colors.deepOrange),
    const ButtonWidget(color: Colors.lightGreen),
    const ButtonWidget(color: Colors.deepPurple),
    const ButtonWidget(color: Colors.blueAccent),
  ];

  int firstCubeMove = 0;
  int secondCubeMove = 0;
  int thirdCubeMove = 0;
  int fourCubeMove = 0;

  int draggedCubeIndex = -1;

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
                //width: 350,
                height: 160,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: SizedBox(
                        height: 50,
                        child: BlocBuilder<MoveButtonsCubit, int>(
                          bloc: widget.moveButtonsCubit,
                          builder: (context, state) {
                            return Row(
                              children: List.generate(
                                buttonsList.length,
                                (index) {
                                  return Visibility(
                                    visible: !(invisibleItem == index),
                                    child: buttonsList[index],
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    /*  Padding(
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
                    Container(
                      color: Colors.yellow,
                      key: widgetKey,
                      child: MouseRegion(
                        onHover: (event) {
                          //print(event.localPosition.dx);
                          //95 один кубик с отспуами

                          /* if(event.localPosition.dx<(95/2)){
                            firstCubeMove = 95;
                          }*/
                        },
                        onEnter: (PointerEnterEvent pointer) {
                          isVisibleChildWhenDragging = true;
                        },
                        onExit: (PointerExitEvent pinter) {
                          isVisibleChildWhenDragging = false;
                          // draggedCubeIndex = -1;
                        },
                        child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: LayoutBuilder(builder: (BuildContext context,
                                BoxConstraints constraints) {
                              return Row(
                                children: List.generate(
                                  buttonsList.length,
                                  (index) {
                                    return Draggable(
                                      data: index,
                                      feedback: buttonsList[index],
                                      onDraggableCanceled:
                                          (Velocity velocity, Offset offset) {
                                        if (!context.mounted) return;
                                        setState(() {
                                          invisibleItem = -1;
                                          //draggedCubeIndex = -1;
                                        });
                                      },
                                      onDragCompleted: () {
                                        setState(() {
                                          invisibleItem = -1;
                                          //draggedCubeIndex = -1;
                                        });
                                      },
                                      onDragUpdate: (dragUpdateDetails) {

                                        widget.moveButtonsCubit.moveBlocks(widgetKey, dragUpdateDetails.globalPosition, buttonsList.length);



                                        //TODO с помощью дельты сделать чтобы кубик не исчезал с первым движением
                                        //print("dragUpdateDetails ${dragUpdateDetails}");
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
                                        onMove:
                                            (DragTargetDetails<int> details) {
                                          // final fdf  = constraints.
                                          //final maxWidth = MediaQuery.of(context).size.width;
                                          //final halfWidth = maxWidth;
                                          draggedCubeIndex = index;

                                          //final dfd = constraints.;
                                          //print(dfd.width);
                                          /// print('onmove ${details.data} / $index');
                                        },
                                        onAcceptWithDetails:
                                            (DragTargetDetails<int> details) {
                                          setState(() {
                                            final buttonWidget =
                                                buttonsList[index];
                                            buttonsList[index] =
                                                buttonsList[details.data];
                                            buttonsList[details.data] =
                                                buttonWidget;
                                          });
                                        },
                                      ),
                                    );
                                  },
                                ),
                              );
                            })),
                      ),
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
