import 'package:flutter/material.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2;
  late SequenceAnimation sequenceAnimation1;
  late SequenceAnimation sequenceAnimation2;
  late Animation<int> slideAnimation;
  late Animation<int> slideAnimation2;
  int screenSize = 500;
  void initAnimation() {
    controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    controller2 = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    slideAnimation = IntTween(begin: 0, end: screenSize).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.easeInOut,
    ));
    slideAnimation2 = IntTween(begin: -screenSize, end: 0).animate(CurvedAnimation(
      parent: controller2,
      curve: Curves.easeInOut,
    ));
    controller.forward();
    controller2.forward();
  }

  @override
  void initState() {
    super.initState();
    initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.blue,
                  height: 100,
                  width: 100,
                  transform: Matrix4.translationValues(0.0, slideAnimation.value.toDouble(), 0.0),
                ),
              ],
            ),
          ),
          AnimatedBuilder(
            animation: controller2,
            builder: (context, child) => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  color: Colors.red,
                  height: 100,
                  width: 100,
                  transform: Matrix4.translationValues(0.0, slideAnimation2.value.toDouble(), 0.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}