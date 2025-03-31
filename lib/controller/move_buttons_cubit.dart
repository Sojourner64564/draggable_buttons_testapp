import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'move_buttons_cubit_state.dart';

class MoveButtonsCubit extends Cubit<MoveButtonsCubitState> {
  MoveButtonsCubit() : super(MoveButtonsCubitState());

  void moveBlocks(GlobalKey widgetKey, Offset cursorPosition, int buttonsAmount, int index){
    print('$index');
    final renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      final containerPosition = renderBox.localToGlobal(Offset.zero);
      final widgetSize = renderBox.size;

      final dx = cursorPosition.dx - containerPosition.dx;
      final dy = cursorPosition.dy - containerPosition.dy;

      if(dx<0 || dy<0) return;
      if(dx>widgetSize.width || dy>widgetSize.height) return;

      final twoIndex = (index+1);
      if(dx<80*twoIndex && dx>80*twoIndex-1){
        if(twoIndex==1){
          emit(MoveButtonsCubitState(index: index, leftPadding: 160, rightPadding: 0));
          return;
        }
        if(twoIndex==buttonsAmount+1){
          emit(MoveButtonsCubitState(index: index, leftPadding: 0, rightPadding: 160));
          return;
        }
        emit(MoveButtonsCubitState(index: index, leftPadding: 0, rightPadding: 160));
      }

      int previousI = 0;
      for (int i = 1; i < ((buttonsAmount*2)+1); i++) {
        if(dx<(80*i)/2 && dx>(80*previousI)/2){



          if(i.isEven){
            emit(MoveButtonsCubitState(index: ((i-1)~/2), leftPadding: 0, rightPadding: 80));
          }else{
            emit(MoveButtonsCubitState(index: ((i-1)~/2), leftPadding: 80, rightPadding: 0));
          }
          break;
        }
        previousI = i;

      }

// 1 - dx<40 && dx>0
// 2 - dx<80 && dx>40
// 3 - dx<120 && dx>80
// 4 - dx<160 && dx>120
    //  print('container $containerPosition');
     // print('cursor $cursorPosition');

      //print('координаты курсора dx:$dx / dy:$dy');


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
