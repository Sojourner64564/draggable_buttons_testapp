import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'move_buttons_cubit_state.dart';

class MoveButtonsCubit extends Cubit<MoveButtonsCubitState> {
  MoveButtonsCubit() : super(MoveButtonsCubitState());

  final int widgetWidth = 80;

  /// Перемещает блоки второго визуального слоя в зависимости от позиции курсора
  ///
  /// [widgetKey] - ключ виджета, относительно которого рассчитывается позиция
  /// [cursorPosition] - текущая позиция курсора в глобальных координатах
  /// [buttonsAmount] - общее количество кнопок
  /// [index] - индекс текущей кнопки
  ///
  /// Алгоритм работы:
  /// 1. Определяет позицию и размеры виджета по его ключу
  /// 2. Проверяет, находится ли курсор в границах виджета
  /// 3. Если курсор в правой половине кнопки - сдвигает блоки вправо
  /// 4. Если курсор в левой половине кнопки - сдвигает блоки влево
  /// 5. В противном случае - определяет зону нахождения курсора и сдвигает соответствующие блоки
  void moveBlocks(GlobalKey widgetKey, Offset cursorPosition, int buttonsAmount, int index){
    // Получаем RenderBox для определения позиции и размеров виджета
    final renderBox = widgetKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox != null) {
      // Позиция виджета в глобальных координатах
      final containerPosition = renderBox.localToGlobal(Offset.zero);
      // Размеры виджета
      final widgetSize = renderBox.size;

      // Позиция курсора относительно виджета
      final dx = cursorPosition.dx - containerPosition.dx;
      final dy = cursorPosition.dy - containerPosition.dy;

      // Если курсор вне границ виджета - выходим
      if(dx<0 || dy<0) return;
      if(dx>widgetSize.width || dy>widgetSize.height) return;

     // print('$dx');

      // Проверка для сдвига при нахождении курсора в зоне между кнопками
      final twoIndex = (index+1);
      if(dx<widgetWidth*twoIndex && dx>widgetWidth*(twoIndex-1)){
        if(twoIndex==1){
          // Сдвиг вправо для первой кнопки
          emit(MoveButtonsCubitState(index: index+1, leftPadding: widgetWidth.toDouble(), rightPadding: 0));
          return;
        }
        // Сдвиг влево для остальных кнопок
        emit(MoveButtonsCubitState(index: index-1, leftPadding: 0, rightPadding: widgetWidth.toDouble()));
          return;
      }

      // Определение зоны нахождения курсора для точного сдвига
      int previousI = 0;
      for (int i = 1; i < ((buttonsAmount*2)+1); i++) {
        if(dx<(widgetWidth*i)/2 && dx>(widgetWidth*previousI)/2){
          if(i.isEven){
            // Сдвиг вправо для четных зон
            emit(MoveButtonsCubitState(index: ((i-1)~/2), leftPadding: 0, rightPadding: widgetWidth.toDouble()));
          }else{
            // Сдвиг влево для нечетных зон
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

  /// Эммитит стейт с дефолтными значениями. Нулевые паддинги и значение индекса -1 означающий,
  /// что одна из "настоящих" кнопок под первым слоем исчезнет и виджет сожметься
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
