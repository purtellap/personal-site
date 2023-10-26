import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps/background/sunset.dart';
import 'package:ps/res/res.dart';
import 'package:ps/background/scene.dart';
import 'dart:math';
import 'package:ps/background/stars.dart';
import '../dialogue/dialogue_provider.dart';
import 'moon.dart';

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
  bool sunset = false;
  bool stars2 = false;

  List<double> ys = [];
  List<double> xs = [];
  List<Color> cs = [];

  late final AnimationController oceanController = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  );

  late final AnimationController sunController = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            sunset = true;
            Future.delayed(
                Duration(seconds: (Dimens.sunsetDuration * 1.45).toInt()), () {
              stars2 = true;
            });
            // moon
            Future.delayed(
                Duration(seconds: (Dimens.sunsetDuration * 1.51).toInt()), () {
              setState(() {
                moonController.forward();
              });
            });
          });
        });
      }
    });

  late final AnimationController sunSetController = AnimationController(
    duration: Duration(seconds: (Dimens.sunsetDuration * 3).toInt()),
    vsync: this,
  );

  late final AnimationController moonController = AnimationController(
    duration: Duration(seconds: (Dimens.sunsetDuration * 1.5).toInt()),
    vsync: this,
  )..addStatusListener((AnimationStatus status) {
      if (status == AnimationStatus.completed && mounted) {
        context.read<DialogueProvider>().comment(Strings.end1);
        Future.delayed(Duration(seconds: 6), () {
          if (mounted) {
            context.read<DialogueProvider>().comment(Strings.end2);
          }
        });
      }
    });

  late final AnimationController cliffController = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,
  );

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Generate controllers for stars
      if (controllers.isEmpty) {
        for (var i = 0; i < numStars; i++) {
          var r = Random();
          AnimationController a = AnimationController(
              vsync: this,
              duration: Duration(
                  seconds: (r.nextDouble() * (starMaxSpeed - starMinSpeed) +
                          starMinSpeed)
                      .toInt()))
            ..forward(from: r.nextDouble())
            ..repeat();
          controllers.add(a);
        }
      }

      List<Color> colors = [Color(0xaaffffff), Color(0x80ffffff)];
      for (var i = 0; i < numStars; i++) {
        var r = Random();
        int num = r.nextInt(100);
        if (num > 95) {
          cs.add(colors[0]);
        } else {
          cs.add(colors[1]);
        }
      }
    });
  }

  @override
  void dispose() {
    if (controllers.isNotEmpty) {
      for (AnimationController c in controllers) {
        c.dispose();
      }
    }
    oceanController.dispose();
    sunController.dispose();
    cliffController.dispose();
    sunSetController.dispose();
    moonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // stars disappear // 10
    Future.delayed(Duration(seconds: 8), () {
      setState(() {
        visibility = false;
      });
    });
    //background (furthest parallax) appears // 20
    Future.delayed(Duration(seconds: 12), () {
      setState(() {
        oceanController.forward();
        sunController.forward();
      });
    });
    //background (closest parallax) appears // 25
    Future.delayed(Duration(seconds: 17), () {
      setState(() {
        cliffController.forward();
      });
    });

    // sunset - reverse not working?? >:(
    Future.delayed(Duration(seconds: 24), () {
      setState(() {
        sunSetController.forward();
      });
    });

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size cts = constraints.biggest;

        return Stack(
          children: <Widget>[
            AnimatedOpacity(
                opacity: visibility ? 1.0 : 0.0,
                duration: Duration(seconds: 10), // 15
                child: Stars(
                  cts: cts,
                  controllers: controllers,
                  ys: ys,
                  colors: cs,
                  xs: xs,
                  sunset: sunset,
                )),
            // sunset stars
            AnimatedOpacity(
                opacity: stars2 ? 1.0 : 0.0,
                duration: Duration(seconds: Dimens.sunsetDuration ~/ 2),
                child: Stars(
                    cts: cts,
                    controllers: controllers,
                    ys: ys,
                    colors: cs,
                    xs: xs,
                    sunset: sunset)),
            Visibility(
                visible: sunset,
                child: Sunset(
                  cts: cts,
                  controller: sunSetController,
                  img: Images.sun,
                  mobileOffset: 3.6,
                  sunset: sunset,
                )),
            Visibility(
                visible: !sunset,
                child: Scene(
                  cts: cts,
                  controller: sunController,
                  img: Images.sun,
                  mobileOffset: 3.6,
                )),
            Moon(
                cts: cts,
                controller: moonController,
                img: Images.moon,
                mobileOffset: 3),
            Scene(
                cts: cts,
                controller: oceanController,
                img: Images.ocean,
                mobileOffset: 3.6),
            Scene(
                cts: cts,
                controller: cliffController,
                img: Images.cliff,
                mobileOffset: 6),
          ],
        );
      },
    );
  }
}
