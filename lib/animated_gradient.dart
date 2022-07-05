import 'package:flutter/material.dart';

class AnimatedGradient extends StatefulWidget {
  @override
  _AnimatedGradientState createState() => _AnimatedGradientState();
}

class _AnimatedGradientState extends State<AnimatedGradient> {
  final List<Color> colors = [
    Colors.black,
    Color(0xff070b34),
    Color(0xff141852),
    Color(0xff2b2f77),
    Color(0xff483475),
    Color(0xffc4595f),
    Color(0xfff89c69)
  ];//.reversed.toList();

  List<Alignment> alignments = [
    Alignment.bottomLeft,
    Alignment.bottomRight,
    Alignment.topRight,
    Alignment.topLeft,
  ];

  int index = 0;
  Color topColor = Colors.black;
  Color bottomColor = Color(0xff010101);
  Alignment begin = Alignment.topCenter;
  Alignment end = Alignment.bottomCenter;

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 10), () {
      setState(() {
        bottomColor = colors[index % colors.length];
      });
    });
    return Scaffold(
        body: Stack(
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 5),
              onEnd: () {
                if(index < colors.length-2) {
                  setState(() {
                    index += 1;
                    bottomColor = colors[index % colors.length];
                    topColor = colors[(index + 1) % colors.length];
                  });
                }
              },
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: begin, end: end, colors: [bottomColor, topColor])),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Container(
            //     width: MediaQuery.of(context).size.width,
            //     height: MediaQuery.of(context).size.width/3,
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         fit: BoxFit.fill,
            //         filterQuality: FilterQuality.none,
            //         isAntiAlias: false,
            //         image: AssetImage('assets/images/ocean1.png'),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ));
  }
}
