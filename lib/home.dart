import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ps/animated_gradient.dart';
import 'package:ps/background.dart';
import 'package:ps/project_items.dart';
import 'package:ps/res/resources.dart';

// class Home extends StatefulWidget {
//
//   @override
//   State<Home> createState() => _HomeState();
// }
//
// class _HomeState extends State<Home> {
//   @override
//   Widget build(BuildContext context) {
//
//     ScrollController controller = ScrollController();
//
//     @override
//     void initState() {
//       super.initState();
//       controller.jumpTo(controller.position.maxScrollExtent);
//     }
//
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       body: Stack(
//         children: [
//         Stack(
//           children: [
//             SingleChildScrollView(
//               controller: controller,
//               child: Container(
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment.topCenter,
//                     end: FractionalOffset.bottomCenter,
//                     colors: [Colors.black, Color(0xff070b34), Color(0xff141852), Color(0xff2b2f77), Color(0xff483475),
//                       Color(0xffc4595f), Color(0xfff89c69)],
//                     // stops: [0, 0.25, 0.5, 0.75, 1],
//                     stops: [0, 0.2, 0.44, 0.64, 0.8, 0.92, 1],
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: List.generate(100, (i) {
//                     return ListTile(
//                       title: SizedBox(),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ],
//         ),
//         ],
//       ),
//     );
//   }
// }

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), (){setState(() {
      visible = true;
    });});
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedGradient(),
          AnimatedOpacity(
            duration: Duration(seconds: 5),
            opacity: visible ? 1.0 : 0.0,
            child: BackgroundStack(isGame: true)),
        ],
      ),
    );
  }
}