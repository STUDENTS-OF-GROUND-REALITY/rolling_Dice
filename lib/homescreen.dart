import 'package:flutter/material.dart';
import 'dart:math';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  int leftDiceNumber = 6;
  int rightDiceNumber = 6;
  AnimationController _controller;
  CurvedAnimation animation;

  @override
  void initState() {
    super.initState();
    animate();
  }
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  animate(){
    _controller = AnimationController( vsync: this, duration: Duration(seconds: 1));
    animation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    animation.addListener(() {
      setState(() {

      });
      print(animation.value);
    });
    animation.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        print('Completed');
        print('');
        setState(() {
          leftDiceNumber = Random().nextInt(6) + 1;
          rightDiceNumber = Random().nextInt(6) + 1;
        });
        _controller.reverse();
      }
    });
  }

  void diceNumber() {
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.redAccent[200],
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Dicee"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: (){ diceNumber(); },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                            'assets/images/dice$leftDiceNumber.png',
                              height: 200-(animation.value)*200,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onDoubleTap: diceNumber,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset(
                            'assets/images/dice$rightDiceNumber.png',
                            height: 200-(animation.value)*200,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: FloatingActionButton.extended(
                onPressed: () {
                  // Add your onPressed code here!
                  diceNumber();
                },
                label: const Text(
                  'Shuffle',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: const Icon(Icons.album_sharp),
                backgroundColor: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
