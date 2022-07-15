import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ps/dialogue_provider.dart';

import 'audio_provider.dart';

class AudioButton extends StatefulWidget {
  const AudioButton({Key? key}) : super(key: key);

  @override
  State<AudioButton> createState() => _AudioButtonState();
}

class _AudioButtonState extends State<AudioButton> {

  @override
  Widget build(BuildContext context) {
    AudioProvider a = context.read<AudioProvider>();

    return Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () async {
            setState(() {
              a.toggleMuted();
            });
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Icon(a.isMuted ? Icons.volume_off : Icons.volume_up, color: Color(0x33ffffff),)),
          ),
        )
    );
  }
}