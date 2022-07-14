import 'package:flutter/material.dart';
import 'package:ps/foreground/hitbox.dart';
import 'package:ps/foreground/paper.dart';
import 'package:ps/res/res.dart';
import 'package:ps/background/scene.dart';
import 'dart:math';

import 'package:ps/background/stars.dart';

class BackgroundStack extends StatefulWidget {
  const BackgroundStack({Key? key}) : super(key: key);

  @override
  State<BackgroundStack> createState() => _BackgroundStackState();
}

class _BackgroundStackState extends State<BackgroundStack>
    with TickerProviderStateMixin {

  int numStars = 70;
  int starMinSpeed = 20; // 30
  int starMaxSpeed = 20; // 30
  List<AnimationController> controllers = [];
  bool visibility = true;

  late final AnimationController oceanController = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,);

  late final AnimationController sunController = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,);

  late final AnimationController cliffController = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,);

  @override
  void dispose() {
    if(controllers.isNotEmpty){
      for (AnimationController c in controllers) {c.dispose();}
    }
    oceanController.dispose();
    sunController.dispose();
    cliffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Generate controllers for stars
    if(controllers.isEmpty){
      for (var i = 0; i < numStars; i++) {
        var r = Random();
        AnimationController a = AnimationController(vsync: this,
            duration: Duration(seconds: (r.nextDouble() * (starMaxSpeed - starMinSpeed) + starMinSpeed).toInt()))
          ..forward(from: r.nextDouble())
          ..repeat();
        controllers.add(a);
      }
    }
    // stars disappear // 10
    Future.delayed(Duration(seconds: 8), (){setState(() {
      visibility = false;
    });});
    //background (furthest parallax) appears // 20
    Future.delayed(Duration(seconds: 12), (){setState(() {
      oceanController.forward();
      sunController.forward();
    });});
    //background (closest parallax) appears // 25
    Future.delayed(Duration(seconds: 17), (){setState(() {
      cliffController.forward();
    });});

    //sun sets
    // Future.delayed(Duration(seconds: 30), (){setState(() {
    //   sunController.reverse();
    // });});

    List<Color> cs = [];
    List<Color> colors = [Color(0xaaffffff), Color(0x80ffffff)];
    for (var i = 0; i < numStars; i++) {
      var r = Random();
      int num = r.nextInt(100);
      if(num > 95){
        cs.add(colors[0]);
      }
      else{
        cs.add(colors[1]);
      }
    }

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size cts = constraints.biggest;

        // Generate y coords for stars with 16 px buffer
        List<double> ys = [];
        for (var i = 0; i < numStars; i++) {
          var r = Random(i);
          ys.add(r.nextDouble() * (cts.height - 32) + 16);
        }

        List<double> xs = [];
        for (var i = 0; i < numStars; i++) {
          var r = Random(i);
          xs.add(r.nextDouble() * (cts.width - 32) + 16);
        }

        return Stack(
          children: <Widget>[
            AnimatedOpacity(
              opacity: visibility ? 1.0 : 0.0,
              duration: Duration(seconds: 10), // 15
              child: Stars(cts: cts, controllers: controllers, ys: xs,colors: cs,)),
            Scene(cts: cts, controller: sunController, img: Images.sun, mobileOffset: 3.6,),
            Scene(cts: cts, controller: oceanController, img: Images.ocean, mobileOffset: 3.6),
            Scene(cts: cts, controller: cliffController, img: Images.cliff, mobileOffset: 6),
          ],
        );
      },
    );
  }
}
