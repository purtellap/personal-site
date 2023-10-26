import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps/foreground/foreground.dart';
import 'package:ps/util/animated_gradient.dart';
import 'package:ps/background/background.dart';

import 'audio/audio_button.dart';
import 'audio/audio_provider.dart';
import 'dialogue/dialogue_provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool backgroundVisible = false;

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        backgroundVisible = true;
      });
    });
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          AnimatedGradient(),
          MultiProvider(
            providers: [
              ChangeNotifierProvider(
                create: (_) => AudioProvider()..init(),
              ),
              ChangeNotifierProvider(
                create: (_) => DialogueProvider()..init(),
              ),
            ],
            child: Consumer<AudioProvider>(
                builder: (context, audioProvider, child) {
              return Consumer<DialogueProvider>(
                  builder: (context, dialogueProvider, child) {
                return Stack(
                  children: [
                    AnimatedOpacity(
                        duration: Duration(seconds: 5),
                        opacity: backgroundVisible ? 1.0 : 0.0,
                        child: BackgroundStack()),
                    ForegroundStack(),
                    _Actions(),
                  ],
                );
              });
            }),
          ),
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // HomeIconButton(
          //   icon: Icons.web_asset_rounded,
          //   onPressed: () => Routes.go(context, Routes.portfolio),
          // ),
          AudioButton(),
        ],
      ),
    );
  }
}

class HomeIconButton extends StatelessWidget {
  final void Function()? onPressed;
  final IconData? icon;
  const HomeIconButton({
    required this.icon,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      splashRadius: 20,
      padding: EdgeInsets.zero,
      visualDensity: VisualDensity.compact,
      color: Color(0x66ffffff),
      hoverColor: Colors.white,
      icon: Icon(icon, size: 24),
    );
  }
}