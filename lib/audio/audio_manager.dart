import 'package:flutter/material.dart';

import 'audio_provider.dart';

class AudioManager extends StatefulWidget {
  final AudioProvider p;
  const AudioManager({Key? key, required this.p}) : super(key: key);

  @override
  State<AudioManager> createState() => _AudioManagerState();
}

class _AudioManagerState extends State<AudioManager> {

  @override
  void dispose() {
    super.dispose();
    widget.p.musicPlayer.dispose();
    widget.p.oceanPlayer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
        alignment: Alignment.topRight,
        child: GestureDetector(
          onTap: () async {
            setState(() {
              widget.p.toggleMuted();
            });
            if(!widget.p.isMuted && !widget.p.musicPlayer.playing){
              widget.p.musicPlayer.play();
            }
            else if(!widget.p.isMuted){
              widget.p.musicPlayer.setVolume(widget.p.musicAudioVolume);
            }
            else{
              widget.p.musicPlayer.setVolume(0);
            }
            if(!widget.p.isMuted){
              widget.p.oceanPlayer.setVolume(widget.p.oceanAudioVolume);
              if(widget.p.isOcean && !widget.p.oceanPlayer.playing){
                widget.p.oceanPlayer.play();
              }
            }
            else{
              widget.p.oceanPlayer.setVolume(0);
            }
          },
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Padding(
                padding: EdgeInsets.all(16),
                child: Icon(widget.p.isMuted ? Icons.volume_off : Icons.volume_up, color: Color(0x33ffffff),)),
          ),
        )
    );
  }
}