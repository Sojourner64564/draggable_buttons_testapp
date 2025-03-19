import 'package:flutter/material.dart';

class CubeRowScreen extends StatefulWidget {
  @override
  _CubeRowScreenState createState() => _CubeRowScreenState();
}

class _CubeRowScreenState extends State<CubeRowScreen> {
  // Позиции кубиков (их смещение по оси X)
  List<double> cubePositions = [0, 100, 200, 300];
  int? draggedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Drag and Displace Cubes in a Row'),
      ),
      body: Center(
        child: Stack(
            children: List.generate(cubePositions.length, (index) {
          return Positioned(
            left: cubePositions[index],
            top: 100,
            child: index == draggedIndex
                ? Draggable(
                    feedback: CubeWidget(color: Colors.blue),
                    childWhenDragging: Opacity(
                      opacity: 0.5,
                      child: CubeWidget(color: Colors.blue),
                    ),
                    onDragStarted: () {
                      setState(() {
                        draggedIndex = index;
                      });
                    },
                    onDragUpdate: (details) {
                      setState(() {
                        // Обновляем позицию перетаскиваемого кубика
                        cubePositions[index] = details.localPosition.dx - 50;
                        // Вытесняем другие кубики
                        _displaceCubes(index);
                      });
                    },
                    onDragEnd: (details) {
                      setState(() {
                        draggedIndex = null;
                      });
                    },
                    child: CubeWidget(color: Colors.blue),
                  )
                : DragTarget<int>(
                    onWillAccept: (data) => true,
                    onAccept: (data) {
                      setState(() {
                        // Обновляем позиции кубиков после завершения перетаскивания
                        _displaceCubes(data);
                      });
                    },
                    builder: (context, candidateData, rejectedData) {
                      return CubeWidget(color: Colors.red);
                    },
                  ),
          );
        })),
      ),
    );
  }

  // Логика вытеснения кубиков
  void _displaceCubes(int draggedIndex) {
    for (int i = 0; i < cubePositions.length; i++) {
      if (i == draggedIndex) continue;

      // Если перетаскиваемый кубик находится над другим кубиком
      if ((cubePositions[draggedIndex] - cubePositions[i]).abs() < 100) {
        if (cubePositions[draggedIndex] < cubePositions[i]) {
          // Сдвигаем кубик вправо
          cubePositions[i] = cubePositions[draggedIndex] + 100;
        } else {
          // Сдвигаем кубик влево
          cubePositions[i] = cubePositions[draggedIndex] - 100;
        }
      }
    }
  }
}

// Виджет кубика
class CubeWidget extends StatelessWidget {
  final Color color;

  CubeWidget({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          'Cube',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
