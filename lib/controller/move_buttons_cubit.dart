import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'move_buttons_cubit_state.dart';

class MoveButtonsCubit extends Cubit<MoveButtonsCubitState> {
  MoveButtonsCubit() : super(MoveButtonsCubitState());

  final int widgetWidth = 80;

  void moveBlocks(GlobalKey widgetKey, Offset cursorPosition, int buttonsAmount, int index){
    final renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final containerPosition = renderBox.localToGlobal(Offset.zero);
      final widgetSize = renderBox.size;

      final dx = cursorPosition.dx - containerPosition.dx;
      final dy = cursorPosition.dy - containerPosition.dy;

      if(dx<0 || dy<0) return;
      if(dx>widgetSize.width || dy>widgetSize.height) return;

      print('$dx');

      final twoIndex = (index+1);
      if(dx<widgetWidth*twoIndex && dx>widgetWidth*(twoIndex-1)){
        if(twoIndex==1){
          emit(MoveButtonsCubitState(index: index+1, leftPadding: widgetWidth.toDouble(), rightPadding: 0));
          return;
        }
          emit(MoveButtonsCubitState(index: index-1, leftPadding: 0, rightPadding: widgetWidth.toDouble()));
          return;
      }

      int previousI = 0;
      for (int i = 1; i < ((buttonsAmount*2)+1); i++) {
        if(dx<(widgetWidth*i)/2 && dx>(widgetWidth*previousI)/2){
          if(i.isEven){
            emit(MoveButtonsCubitState(index: ((i-1)~/2), leftPadding: 0, rightPadding: widgetWidth.toDouble()));
          }else{
            emit(MoveButtonsCubitState(index: ((i-1)~/2), leftPadding: widgetWidth.toDouble(), rightPadding: 0));
          }
          break;
        }
        previousI = i;
      }

// 1 - dx<40 && dx>0
// 2 - dx<80 && dx>40
// 3 - dx<120 && dx>80
// 4 - dx<160 && dx>120

    }
  }

  void deletePaddings(){
    emit(MoveButtonsCubitState());
  }


}


/*
const SizedBox(
  width: 80,
  height: 50,
),
 */
