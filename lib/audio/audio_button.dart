import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../home.dart';
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

    return HomeIconButton(
      onPressed: () async => setState(() => a.toggleMuted()),
      icon: a.isMuted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
    );
  }
}
