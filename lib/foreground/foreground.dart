import 'package:flutter/material.dart';
import 'package:ps/dialogue.dart';
import 'package:ps/foreground/hitbox.dart';
import 'package:ps/foreground/paper.dart';
import 'package:ps/res/res.dart';

class ForegroundStack extends StatefulWidget {
  const ForegroundStack({Key? key}) : super(key: key);

  @override
  State<ForegroundStack> createState() => _ForegroundStackState();
}

class _ForegroundStackState extends State<ForegroundStack>
    with TickerProviderStateMixin {

  bool visibility = true;

  late final AnimationController controller = AnimationController(
    duration: const Duration(seconds: 5),
    vsync: this,);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Future.delayed(Duration(seconds: 17), (){setState(() {
      controller.forward();
    });});

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final Size cts = constraints.biggest;

        return Stack(
          children: <Widget>[
            Paper(cts: cts, controller: controller, img: Images.paper),
            HitBox(cts: cts, controller: controller),
            //InputDialogue(cts: cts, controller: controller,),
            TalkDialogue(cts: cts, controller: controller)
          ],
        );
      },
    );
  }
}
