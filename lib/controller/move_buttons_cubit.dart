import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MoveButtonsCubit extends Cubit<int> {
  MoveButtonsCubit() : super(0);

  void moveBlocks(GlobalKey widgetKey, Offset cursorPosition, int buttonsAmount){
    final renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final containerPosition = renderBox.localToGlobal(Offset.zero);
      final widgetSize = renderBox.size;

      final dx = cursorPosition.dx - containerPosition.dx;
      final dy = cursorPosition.dy - containerPosition.dy;

      if(dx<0 || dy<0) return;
      if(dx>widgetSize.width || dy>widgetSize.height) return;



      print('container $containerPosition');
      print('cursor $cursorPosition');

      print('координаты курсора dx:$dx / dy:$dy');


    }

  }


}


/*
const SizedBox(
  width: 80,
  height: 50,
),
 */
