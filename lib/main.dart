import 'package:draggable_buttons_testapp/draggable_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: const DraggableScreen(),
    );
  }
}




/*






import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
    );
  }
}

class ReOrderedListView extends StatefulWidget {
  const ReOrderedListView({super.key});

  @override
  State<ReOrderedListView> createState() => _ReOrderedListViewState();
}

class _ReOrderedListViewState extends State<ReOrderedListView> {
  // list of tiles
  final List myTiles = [
    'A',
    'B',
    'C',
    'D',
  ];

  // reorder method
  void updateMyTiles(int oldIndex, int newIndex) {
    setState(() {
      // this adjustment is needed when moving down the list
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }

      // get the tile we are moving
      final String tile = myTiles.removeAt(oldIndex);
      // place the tile in new position
      myTiles.insert(newIndex, tile);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Re-Orderable ListView")),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 60,
            child: ReorderableListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(10),
              children: [
                for (final tile in myTiles)
                  Padding(
                    key: ValueKey(tile),
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 200,
                      height: 50,
                      color: Colors.grey[200],
                      child: Text(tile.toString()),
                    ),
                  ),
              ],
              onReorder: (oldIndex, newIndex) {
                updateMyTiles(oldIndex, newIndex);
              },
            ),
          ),
        ],
      ),
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  bool insideTarget = false;
  String activeEmoji = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('insideTagrt: $insideTarget'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            DragTarget<String>(
              onAcceptWithDetails:(DragTargetDetails<String> dragDetails){
                setState(() {
                  insideTarget = true;
                  activeEmoji = dragDetails.data;
                });
              },
              onMove: (DragTargetDetails<String> dragTargetDetails){
                print(dragTargetDetails.offset.dx);
                print(dragTargetDetails.offset.dy);

              },
              builder: (context, data, rejectedDate){
              return Container(
                width: 200,
                height: 200,
                color: Colors.blue,
                child: activeEmoji == '' ? null : FruitBox(boxIcon: activeEmoji, boxColor: Colors.blue),
              );
            },
            ),
            const Row(
              children: [
                FruitBox(boxIcon: 'apple', boxColor: Colors.red),
                FruitBox(boxIcon: 'yellow', boxColor: Colors.yellow),
              ],
            ),
          ],
        )
      ),
    );
  }
}


class FruitBox extends StatelessWidget {
  const FruitBox({super.key, required this.boxIcon, required this.boxColor});
  final String boxIcon;
  final Color boxColor;
  @override
  Widget build(BuildContext context) {
    return  Draggable(
      data: boxIcon,
      feedback: Container(
        width: 120,
        height: 120,
        color: Colors.yellow,
        child: Center(
          child: Text(boxIcon, style: const TextStyle(fontSize: 50),),
        ),
      ),
      childWhenDragging: Container(
        width: 120,
        height: 120,
        color: Colors.grey,
      ),
      child: Container(
        width: 120,
        height: 120,
        color: boxColor,
        child: Center(
          child: Text(boxIcon, style: const TextStyle(fontSize: 50),),
        ),
      ),
    );
  }
}

*/
