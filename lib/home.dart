import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps/dialogue_provider.dart';
import 'package:ps/foreground/foreground.dart';
import 'package:ps/util/animated_gradient.dart';
import 'package:ps/background/background.dart';

import 'audio/audio_manager.dart';
import 'audio/audio_provider.dart';

class Home extends StatefulWidget {

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool backgroundVisible = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), (){setState(() {
      backgroundVisible = true;
    });});
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedGradient(),
          AnimatedOpacity(
              duration: Duration(seconds: 5),
              opacity: backgroundVisible ? 1.0 : 0.0,
              child: BackgroundStack()),
          MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => AudioProvider()..init(),),
              ChangeNotifierProvider(create: (_) => DialogueProvider()..init(),),
            ],
            child: Consumer<AudioProvider>(
              builder: (context, audioProvider, child) {
                return Consumer<DialogueProvider>(
                    builder: (context, dialogueProvider, child) {
                      return Stack(
                        children: [
                          ForegroundStack(),
                          AudioManager(p: audioProvider,),
                        ],
                      );
                    }
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}