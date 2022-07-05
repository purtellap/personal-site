import 'package:flutter/material.dart';
import 'package:ps/paper.dart';
import 'package:ps/res/resources.dart';
import 'package:ps/scene.dart';
import 'dart:math';

import 'package:ps/stars.dart';

class BackgroundStack extends StatefulWidget {
  const BackgroundStack({Key? key, required this.isGame}) : super(key: key);

  final bool isGame;

  @override
  State<BackgroundStack> createState() => _BackgroundStackState();
}

class _BackgroundStackState extends State<BackgroundStack>
    with TickerProviderStateMixin {

  int numStars = 70;
  int starMinSpeed = 30;
  int starMaxSpeed = 30;
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
    Future.delayed(Duration(seconds: 10), (){setState(() {
      visibility = false;
    });});
    Future.delayed(Duration(seconds: 20), (){setState(() {
      oceanController.forward();
      sunController.forward();
    });});
    // Future.delayed(Duration(seconds: 30), (){setState(() {
    //   sunController.reverse();
    // });});
    Future.delayed(Duration(seconds: 25), (){setState(() {
      cliffController.forward();
    });});

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
              duration: Duration(seconds: 15),
              child: Stars(cts: cts, controllers: controllers, ys: xs,colors: cs,)),
            Scene(cts: cts, controller: sunController, img: Images.sun,),
            Scene(cts: cts, controller: oceanController, img: Images.ocean,),
            Scene(cts: cts, controller: cliffController, img: Images.cliff,),
            Paper(cts: cts, controller: cliffController, img: Images.paper,),
          ],
        );
      },
    );
  }
}
