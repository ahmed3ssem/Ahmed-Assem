import 'dart:math';

import 'package:flutter/material.dart';

/*
 First Task : app consists of FAB and container
 when i pressed on FAB it changes container Color
 but when i pressed on FAB it Rebuild Background widget
 which it doesn't no need to rebuild
 you need to optimize build function as
 when i pressed on Button don't rebuild Background widget
 */

class ColorNotifier extends ChangeNotifier {
  Color myColor = Colors.grey;
  Random _random = new Random();

  void changeColor() {
    int randomNumber = _random.nextInt(30);
    myColor = Colors.primaries[randomNumber % Colors.primaries.length];
    notifyListeners();
  }
}
class FirstTaskScreen extends StatefulWidget {
  @override
  _FirstTaskScreenState createState() => _FirstTaskScreenState();
}

class BackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building BackgroundWidget");

    return Container(color: Colors.amber);
  }
}

class _FirstTaskScreenState extends State<FirstTaskScreen> {
  final _notifier = ColorNotifier();

  @override
  Widget build(BuildContext context) {
    print("Building FirstTaskScreen");
    return Scaffold(
      appBar: AppBar(
        title: Text("First task"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _notifier.changeColor();
        },
        child: Icon(Icons.colorize),
      ),
      body: Stack(
        children: [
          Positioned.fill(child: BackgroundWidget()),
          Center(
            child: AnimatedBuilder(
              animation: _notifier,
              builder: (_, __) => Container(
                height: 150,
                width: 150,
                color: _notifier.myColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
