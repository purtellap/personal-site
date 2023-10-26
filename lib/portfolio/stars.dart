import 'dart:math';
import 'package:flutter/material.dart';

class PortfolioStars extends StatefulWidget {
  final double width;
  final double height;
  PortfolioStars({
    required this.width,
    required this.height,
  });
  @override
  _PortfolioStarsState createState() => _PortfolioStarsState();
}

class _PortfolioStarsState extends State<PortfolioStars>
    with TickerProviderStateMixin {
  List<AnimationController> controllers = [];
  List<Animation<double>> animations = [];
  List<Animation<double>> opacityAnimations = [];
  List<Offset> initialPositions = [];
  final Random random = Random();

  final int amount = 50;
  final double diameter = 2;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < amount; i++) {
      double randomOpacityStart = random.nextDouble() * 0.5;
      double randomOpacityEnd = 0.5 + random.nextDouble() * 0.5;

      AnimationController controller = AnimationController(
          vsync: this, duration: Duration(seconds: random.nextInt(8) + 24))
        ..forward(from: random.nextDouble())
        ..repeat();

      controllers.add(controller);

      Animation<double> animation =
          Tween<double>(begin: 0, end: widget.height).animate(
        CurvedAnimation(parent: controller, curve: Curves.linear),
      );
      animations.add(animation);

      Animation<double> opacityAnimation = Tween<double>(
              begin: randomOpacityStart, end: randomOpacityEnd)
          .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
      opacityAnimations.add(opacityAnimation);

      initialPositions.add(Offset(Random().nextDouble() * widget.width, 0));
    }
  }

  @override
  void dispose() {
    for (var controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: Stack(
        children: List.generate(
          amount,
          (index) => buildStar(index),
        ),
      ),
    );
  }

  Widget buildStar(int index) {
    return AnimatedBuilder(
      animation: controllers[index],
      builder: (context, child) {
        double dx = initialPositions[index].dx +
            200 * sin(animations[index].value / 200);
        double dy = initialPositions[index].dy + animations[index].value;
        return Positioned(
          left: dx % widget.width,
          top: dy,
          child: Opacity(
            opacity: opacityAnimations[index].value,
            child: child,
          ),
        );
      },
      child: Container(
        width: diameter,
        height: diameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }
}
