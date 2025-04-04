import 'package:draggable_buttons_testapp/controller/move_buttons_cubit.dart';
import 'package:draggable_buttons_testapp/widget/button_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/empty_button_space_widget.dart';

class DraggablePage extends StatefulWidget {
  DraggablePage({super.key});

  final MoveButtonsCubit moveButtonsCubit = MoveButtonsCubit();
  final double buttonsWidth = 80;
  @override
  State<DraggablePage> createState() => _DraggablePageState();
}

class _DraggablePageState extends State<DraggablePage> {
  final GlobalKey widgetKey = GlobalKey();
  bool isVisibleChildWhenDragging = true;
  int invisibleItem = -1;

  List<Widget> buttonsList = [
    const ButtonWidget(color: Colors.teal, assetLink: 'assets/img_icons/command_icon.png',),
    const ButtonWidget(color: Colors.lightGreen, assetLink: 'assets/img_icons/computer_first_icon.png',),
    const ButtonWidget(color: Colors.indigo, assetLink: 'assets/img_icons/computer_second_icon.png',),
    const ButtonWidget(color: Colors.yellow, assetLink: 'assets/img_icons/power_plug_icon.png',),
  ];

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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    height: 50,
                    child: Stack(
                      children: [
                        SizedBox(
                          key: widgetKey,
                          child: MouseRegion(
                            onEnter: (PointerEnterEvent pointer) {
                              isVisibleChildWhenDragging = true;
                            },
                            onExit: (PointerExitEvent pinter) {
                              widget.moveButtonsCubit.deletePaddings();
                              isVisibleChildWhenDragging = false;
                            },
                            child: Row(
                                children: List.generate(
                                  buttonsList.length,
                                  (index) {
                                    return Draggable(
                                      data: index,
                                      feedback: buttonsList[index],
                                      onDraggableCanceled: (Velocity velocity, Offset offset) {
                                        widget.moveButtonsCubit.deletePaddings();
                                        if (!context.mounted) return;
                                        setState(() {
                                          invisibleItem = -1;
                                        });
                                      },
                                      onDragCompleted: () {
                                        widget.moveButtonsCubit.deletePaddings();
                                        setState(() {
                                          invisibleItem = -1;
                                        });
                                      },
                                      onDragUpdate: (dragUpdateDetails) {
                                        widget.moveButtonsCubit.moveBlocks(widgetKey, dragUpdateDetails.globalPosition, buttonsList.length, index);

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
                                          return const EmptyButtonSpaceWidget();
                                        },
                                        onMove: (DragTargetDetails<int> details) {
                                          draggedCubeIndex = index;
                                        },
                                        onAcceptWithDetails: (DragTargetDetails<int> details) {
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
                              ),
                          ),
                        ),
                        IgnorePointer(
                          child: SizedBox(
                            height: 50,
                            child: BlocBuilder<MoveButtonsCubit, MoveButtonsCubitState>(
                              bloc: widget.moveButtonsCubit,
                              builder: (context, state) {
                                return Row(
                                  children: List.generate(
                                    buttonsList.length,
                                        (index) {
                                      return Visibility(
                                        visible: !(invisibleItem == index),
                                        child: AnimatedPadding(
                                          padding: index==state.index ? EdgeInsets.only(left: state.leftPadding, right: state.rightPadding) : EdgeInsets.zero,
                                          duration: const Duration(milliseconds: 100),
                                          child: buttonsList[index],
                                        ),
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
