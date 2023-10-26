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

  final int amount = 50;
  final double diameter = 2;

  @override
  void initState() {
    super.initState();

    for (int i = 0; i < amount; i++) {
      AnimationController controller = AnimationController(
          vsync: this, duration: Duration(seconds: Random().nextInt(10) + 20))
        ..forward()
        ..repeat();
      controllers.add(controller);

      Animation<double> animation =
          Tween<double>(begin: 0, end: widget.height).animate(
        CurvedAnimation(parent: controller, curve: Curves.linear),
      );
      animations.add(animation);

      Animation<double> opacityAnimation = Tween<double>(begin: 0.1, end: 1)
          .animate(CurvedAnimation(parent: controller, curve: Curves.linear));
      opacityAnimations.add(opacityAnimation);

      initialPositions.add(
        Offset(
          Random().nextDouble() * widget.width,
          Random().nextDouble() * widget.height,
        ),
      );
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
    return Stack(
      children: List.generate(
        amount,
        (index) {
          return AnimatedBuilder(
            animation: controllers[index],
            builder: (context, child) {
              double dx = initialPositions[index].dx + animations[index].value;
              double dy = initialPositions[index].dy + animations[index].value;
              return Positioned(
                left: dx % widget.width,
                top: dy % widget.height,
                child: Opacity(
                  opacity: opacityAnimations[index].value,
                  child: Container(
                    width: diameter,
                    height: diameter,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
