import 'package:draggable_buttons_testapp/controller/move_buttons_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widget/empty_button_space_widget.dart';

class DraggablePage extends StatefulWidget {
  DraggablePage({super.key, required this.menuWidgetList, required this.animationDuration});

  final MoveButtonsCubit moveButtonsCubit = MoveButtonsCubit();
  final double buttonsWidth = 80;
  final List<Widget> menuWidgetList;
  final int animationDuration;

  @override
  State<DraggablePage> createState() => _DraggablePageState();
}

class _DraggablePageState extends State<DraggablePage> {
  final GlobalKey widgetKey = GlobalKey();
  bool _isVisibleChildWhenDragging = true;
  int _invisibleItem = -1;

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
                              _isVisibleChildWhenDragging = true;
                            },
                            onExit: (PointerExitEvent pinter) {
                              widget.moveButtonsCubit.deletePaddings();
                              _isVisibleChildWhenDragging = false;
                            },
                            child: Row(
                                children: List.generate(
                                  widget.menuWidgetList.length,
                                  (index) {
                                    return Draggable(
                                      data: index,
                                      feedback: widget.menuWidgetList[index],
                                      onDraggableCanceled: (Velocity velocity, Offset offset) {
                                        if (!context.mounted) return;
                                        widget.moveButtonsCubit.deletePaddings();
                                        setState(() {
                                          _invisibleItem = -1;
                                        });
                                        print('onDraggableCanceled');
                                      },
                                      onDragCompleted: () {
                                        if (!context.mounted) return;
                                        widget.moveButtonsCubit.deletePaddings();
                                        setState(() {
                                          _invisibleItem = -1;
                                        });
                                        print('onDragCompleted');

                                      },
                                      onDragUpdate: (dragUpdateDetails) {
                                        widget.moveButtonsCubit.moveBlocks(widgetKey, dragUpdateDetails.globalPosition, widget.menuWidgetList.length, index);

                                        //TODO с помощью дельты сделать чтобы кубик не исчезал с первым движением
                                        _invisibleItem = index;
                                        ///TODO как-то оптимизировать этот момент
                                        setState(() {});
                                        print('onDragUpdate');
                                      },
                                      childWhenDragging: Visibility(
                                        visible: _isVisibleChildWhenDragging,
                                        child: const SizedBox(
                                          width: 80,
                                          height: 50,
                                        ),
                                      ),
                                      child: DragTarget<int>(
                                        builder: (BuildContext context, List<dynamic> accepted, List<dynamic> rejected) {
                                          return EmptyButtonSpaceWidget(
                                            widgetWidth: widget.buttonsWidth,
                                          );
                                        },
                                        onAcceptWithDetails: (DragTargetDetails<int> details) {
                                          setState(() {
                                            final buttonWidget = widget.menuWidgetList[index];
                                            widget.menuWidgetList[index] = widget.menuWidgetList[details.data];
                                            widget.menuWidgetList[details.data] = buttonWidget;
                                          });
                                          print('onAcceptWithDetails');
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
                                    widget.menuWidgetList.length,
                                        (index) {
                                      return Visibility(
                                        visible: !(_invisibleItem == index),
                                        child: AnimatedPadding(
                                          padding: index==state.index ? EdgeInsets.only(left: state.leftPadding, right: state.rightPadding) : EdgeInsets.zero,
                                          duration: Duration(milliseconds: widget.animationDuration),
                                          child: widget.menuWidgetList[index],
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
